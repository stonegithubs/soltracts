// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { console } from "./utils/Console.sol";
import { BaseTest } from "./utils/BaseTest.sol";
import { MockProxyRegistry } from "./utils/mocks/MockProxyRegistry.sol";
import { MockERC721ATradable } from "./utils/mocks/MockERC721ATradable.sol";

contract TestERC721ATradable is BaseTest {
	MockProxyRegistry private proxyRegistry;
	MockERC721ATradable private erc721aTradable;

	function setUp() public {
		proxyRegistry = new MockProxyRegistry();
		erc721aTradable = new MockERC721ATradable("testname", "testsymbol", address(proxyRegistry));
	}

	function testDeployGas() public {
		unchecked {
			new MockERC721ATradable("abcdefg", "xyz", getRandomAddress(0x69));
		}
	}

	function testIsApprovedForAll() public {
		address from = address(0x69);
		vm.startPrank(from);

		erc721aTradable.safeMint(from, 5);

		address proxy = proxyRegistry.registerProxy(from);

		assertTrue(erc721aTradable.isApprovedForAll(from, proxy));
	}
}
