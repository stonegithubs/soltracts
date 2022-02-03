// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { IProxyRegistry } from "../../../tokens/ERC721/extensions/ERC721ATradable.sol";

// solhint-disable no-empty-blocks

contract MockProxyRegistry is IProxyRegistry {
    event ProxyRegistered(address indexed registrant, address indexed proxy);

    mapping(address => address) private _proxies;
    
    function registerProxy(address registrant) external {
        address proxy = address(uint160(uint256(keccak256(abi.encodePacked(registrant)))));
        _proxies[registrant] = proxy;
        emit ProxyRegistered(msg.sender, proxy);
    }

    function proxies(address registrant) external view returns (address) {
        return _proxies[registrant];
    }
}
