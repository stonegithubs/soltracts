// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// solhint-disable no-empty-blocks

contract MockProxy {
    function gm() external pure returns (string memory) {
        return "gm";
    }
}

contract MockProxyRegistry {
    event ProxyRegistered(address indexed registrant, address indexed proxy);

    mapping(address => MockProxy) public proxies;
    
    function registerProxy(address registrant) external returns (address) {
        MockProxy proxy = new MockProxy();
        proxies[registrant] = proxy;
        emit ProxyRegistered(msg.sender, address(proxy));
        return address(proxy);
    }
}

