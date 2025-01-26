
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Forwarder {
    mapping(address => uint256) public nonces;
    
    struct ERC20ForwardRequest {
        address from;
        address to;
        address tokenContract;
        uint256 amount;
        uint256 nonce;
        uint256 deadline;
    }

    struct ERC721ForwardRequest {
        address from;
        address to;
        address tokenContract;
        uint256 tokenId;
        uint256 nonce;
        uint256 deadline;
    }

    event ERC20TransactionForwarded(address indexed from, address indexed to, address indexed tokenContract, uint256 amount);
    event ERC721TransactionForwarded(address indexed from, address indexed to, address indexed tokenContract, uint256 tokenId);

    // Custom errors for gas efficiency
    error InvalidSignature();
    error TransactionExpired();
    error InvalidNonce();
    error TransferFailed();

    function forwardERC20Transaction(ERC20ForwardRequest calldata req, bytes calldata signature) external {
        if (block.timestamp > req.deadline) revert TransactionExpired();
        if (nonces[req.from] != req.nonce) revert InvalidNonce();
        
        bytes32 digest = keccak256(abi.encodePacked(
            "\x19Ethereum Signed Message:\n32",
            keccak256(abi.encode(
                req.from,
                req.to,
                req.tokenContract,
                req.amount,
                req.nonce,
                req.deadline
            ))
        ));

        address signer = recoverSigner(digest, signature);
        if (signer != req.from) revert InvalidSignature();

        nonces[req.from]++;

        (bool success, bytes memory data) = req.tokenContract.call(
            abi.encodeWithSelector(0xa9059cbb, req.to, req.amount)
        );
        if (!success || (data.length != 0 && !abi.decode(data, (bool)))) revert TransferFailed();

        emit ERC20TransactionForwarded(req.from, req.to, req.tokenContract, req.amount);
    }

    function forwardERC721Transaction(ERC721ForwardRequest calldata req, bytes calldata signature) external {
        if (block.timestamp > req.deadline) revert TransactionExpired();
        if (nonces[req.from] != req.nonce) revert InvalidNonce();
        
        bytes32 digest = keccak256(abi.encodePacked(
            "\x19Ethereum Signed Message:\n32",
            keccak256(abi.encode(
                req.from,
                req.to,
                req.tokenContract,
                req.tokenId,
                req.nonce,
                req.deadline
            ))
        ));

        address signer = recoverSigner(digest, signature);
        if (signer != req.from) revert InvalidSignature();

        nonces[req.from]++;

        (bool success, ) = req.tokenContract.call(
            abi.encodeWithSelector(0x23b872dd, req.from, req.to, req.tokenId)
        );
        if (!success) revert TransferFailed();

        emit ERC721TransactionForwarded(req.from, req.to, req.tokenContract, req.tokenId);
    }

    function getNonce(address user) external view returns (uint256) {
        return nonces[user];
    }

    function recoverSigner(bytes32 _ethSignedMessageHash, bytes memory _signature) internal pure returns (address) {
        (bytes32 r, bytes32 s, uint8 v) = splitSignature(_signature);
        return ecrecover(_ethSignedMessageHash, v, r, s);
    }

    function splitSignature(bytes memory sig) internal pure returns (bytes32 r, bytes32 s, uint8 v) {
        require(sig.length == 65, "Invalid signature length");

        assembly {
            r := mload(add(sig, 32))
            s := mload(add(sig, 64))
            v := byte(0, mload(add(sig, 96)))
        }

        if (v < 27) {
            v += 27;
        }

        require(v == 27 || v == 28, "Invalid signature 'v' value");
    }
}
