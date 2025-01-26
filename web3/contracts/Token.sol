// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title GaslessToken
 * @dev ERC20 token with permit functionality for gasless transactions
 * Extends OpenZeppelin's ERC20 and Permit implementations
 */
contract GaslessToken is ERC20Permit, Ownable {
    uint256 public constant INITIAL_SUPPLY = 1_000_000 * 10 ** 18; // 1 million tokens
    uint8 private constant DECIMALS = 18;

    constructor()
        ERC20("GaslessToken", "GLT")
        ERC20Permit("GaslessToken")
        Ownable(msg.sender)
    {
        // Mint initial supply to contract deployer
        _mint(msg.sender, INITIAL_SUPPLY);
    }

    /**
     * @dev Mint new tokens to a specific address
     * @param to Address to receive the minted tokens
     * @param amount Number of tokens to mint
     */
    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }

    /**
     * @dev Burns a specific amount of tokens
     * @param amount Number of tokens to burn
     */
    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
    }
}