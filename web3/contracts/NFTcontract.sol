// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title GaslessNFT
 * @dev ERC721 token with advanced minting capabilities
 */
contract GaslessNFT is ERC721Enumerable, Ownable {
    // Internal counter for token IDs
    uint256 private _currentTokenId = 0;

    // Base URI for token metadata
    string private _baseTokenURI;

    // Maximum supply of NFTs
    uint256 public constant MAX_SUPPLY = 10_000;

    // Minting price
    uint256 public mintPrice = 0.001 ether;

    constructor(
        string memory baseURI
    ) ERC721("GaslessNFT", "GNFT") Ownable(msg.sender) {
        _baseTokenURI = baseURI;
    }

    /**
     * @dev Mint a new NFT
     * @param recipient Address to receive the new NFT
     * @param tokenURI Metadata URI for the new token
     * @return uint256 ID of the newly minted token
     */
    function mint(
        address recipient,
        string memory tokenURI
    ) public returns (uint256) {
        require(totalSupply() < MAX_SUPPLY, "Max supply reached");

        // Increment the token ID
        _currentTokenId++;
        uint256 newTokenId = _currentTokenId;

        _safeMint(recipient, newTokenId);

        return newTokenId;
    }

    /**
     * @dev Set the base URI for token metadata
     * @param baseURI New base URI to set
     */
    function setBaseURI(string memory baseURI) external onlyOwner {
        _baseTokenURI = baseURI;
    }

    /**
     * @dev Internal function to get base URI
     * @return string Base URI for tokens
     */
    function _baseURI() internal view virtual override returns (string memory) {
        return _baseTokenURI;
    }
}