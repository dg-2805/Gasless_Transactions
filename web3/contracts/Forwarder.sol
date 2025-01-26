// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import "@openzeppelin/contracts/utils/cryptography/EIP712.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

/**
 * @title GaslessForwarder
 * @dev Contract to enable meta-transactions (gasless transactions)
 */
contract GaslessForwarder is EIP712 {
    using ECDSA for bytes32;

    // EIP-712 type hash for the ForwardRequest
    bytes32 private constant FORWARD_REQUEST_TYPEHASH =
        keccak256(
            "ForwardRequest(address from,address to,address token,uint256 value,uint256 nonce,bytes data)"
        );

    // Nonce tracking for each user to prevent replay attacks
    mapping(address => uint256) private _nonces;

    // Trusted tokens that can be transferred via this forwarder
    mapping(address => bool) public trustedTokens;

    constructor() EIP712("GaslessForwarder", "1") {}

    /**
     * @dev Add a token contract to the list of trusted tokens
     * @param tokenAddress Address of the token contract
     */
    function addTrustedToken(address tokenAddress) external {
        trustedTokens[tokenAddress] = true;
    }

    /**
     * @dev Get the current nonce for a user
     * @param user Address of the user
     * @return Current nonce
     */
    function getNonce(address user) external view returns (uint256) {
        return _nonces[user];
    }

    /**
     * @dev Verify the signature for a forward request
     * @param request Struct containing transaction details
     * @param signature Signature to verify
     * @return Boolean indicating signature validity
     */
    function verify(
        ForwardRequest memory request,
        bytes memory signature
    ) public view returns (bool) {
        address signer = _hashTypedDataV4(
            keccak256(
                abi.encode(
                    FORWARD_REQUEST_TYPEHASH,
                    request.from,
                    request.to,
                    request.token,
                    request.value,
                    request.nonce,
                    keccak256(request.data)
                )
            )
        ).recover(signature);

        return signer == request.from && _nonces[request.from] == request.nonce;
    }

    /**
     * @dev Execute a forward request for token transfer
     * @param request Struct containing transaction details
     * @param signature Signature authorizing the transaction
     */
    function execute(
        ForwardRequest memory request,
        bytes memory signature
    ) public payable {
        // Verify the request
        require(verify(request, signature), "Invalid signature or nonce");
        require(trustedTokens[request.token], "Untrusted token");

        // Increment nonce to prevent replay
        _nonces[request.from]++;

        // Determine if it's an ERC20 or ERC721 transfer
        if (request.data.length > 0) {
            // Attempt ERC721 transfer
            (bool success, ) = request.token.call(
                abi.encodeWithSignature(
                    "safeTransferFrom(address,address,uint256)",
                    request.from,
                    request.to,
                    request.value
                )
            );
            require(success, "ERC721 transfer failed");
        } else {
            // ERC20 transfer
            IERC20 token = IERC20(request.token);
            require(
                token.transferFrom(request.from, request.to, request.value),
                "ERC20 transfer failed"
            );
        }
    }

    /**
     * @dev Struct to represent a forward request
     */
    struct ForwardRequest {
        address from; // Sender of the original transaction
        address to; // Recipient of the transaction
        address token; // Token contract address
        uint256 value; // Amount or token ID
        uint256 nonce; // Prevent replay attacks
        bytes data; // Additional data (empty for ERC20, tokenId for ERC721)
    }
}