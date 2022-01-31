// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import { DSTest } from "ds-test/test.sol";
import { Utilities } from "./utils/Utilities.sol";
import { console } from "./utils/Console.sol";
import { Hevm } from "./utils/Hevm.sol";
import { ExampleERC721A } from "../tokens/ERC721/ExampleERC721A.sol";

contract TestERC721A is DSTest {
	Hevm internal immutable vm = Hevm(HEVM_ADDRESS);

	ExampleERC721A internal erc721a;

	function setUp() public {
		erc721a = new ExampleERC721A("testname", "testsymbol", "https://example.com/12345/");
	}

	function testDeployGas() public {
		unchecked {
			new ExampleERC721A("abcdefg", "xyz", "https://example.com/12345/");
		}
	}

	function testSafeMint() public {
		uint256 _amount = 5;
		erc721a.safeMint(address(this), _amount);
		assertEq(erc721a.balanceOf(address(this)), _amount);
	}

	function testSafeMintGas1() public {
		unchecked {
			erc721a.safeMint(address(1), 1);
		}
	}

	function testSafeMintGas2() public {
		unchecked {
			erc721a.safeMint(address(1), 2);
		}
	}

	function testSafeMintGas3() public {
		unchecked {
			erc721a.safeMint(address(1), 3);
		}
	}

	function testSafeMintGas4() public {
		unchecked {
			erc721a.safeMint(address(1), 4);
		}
	}

	function testSafeMintGas5() public {
		unchecked {
			erc721a.safeMint(address(1), 5);
		}
	}

	// First transfer, 51755
	// Second transfer, 9623
	function testTransferFromGas() public {
		address to = getRandomAddress(420);
		erc721a.safeMint(address(this), 2);

		uint256 g = gasleft();
		erc721a.transferFrom(address(this), to, 1);
		console.log("First transfer", g - gasleft());

		assertEq(erc721a.balanceOf(address(this)), 1);
		assertEq(erc721a.balanceOf(to), 1);

		g = gasleft();
		erc721a.transferFrom(address(this), to, 2);
		console.log("Second transfer", g - gasleft());

		assertEq(erc721a.balanceOf(address(this)), 0);
		assertEq(erc721a.balanceOf(to), 2);
	}

  	// First transfer, 54388
  	// Second transfer, 9756
	function testSafeTransferFromGas() public {
		address to = getRandomAddress(69);
		erc721a.safeMint(address(this), 2);

		uint256 g = gasleft();
		erc721a.safeTransferFrom(address(this), to, 1);
		console.log("First transfer", g - gasleft());

		g = gasleft();
		erc721a.safeTransferFrom(address(this), to, 2);
		console.log("Second transfer", g - gasleft());
	}

	uint256 internal constant amount = 5;
	// average: 29000-30500 per token
	function testBatchTransferFromGas() public {
		address to = getRandomAddress(69420);

		erc721a.safeMint(address(this), amount);

		uint256[] memory ids = new uint256[](amount);
		for(uint256 i; i < amount; i++) {
			ids[i] = i + 1;
		}

		uint256 g = gasleft();
		erc721a.batchTransferFrom(address(this), to, ids);
		g -= gasleft();
		console.log("Transfer gas", g);
		console.log("Average", g / amount);

		assertEq(erc721a.balanceOf(address(this)), 0);
		assertEq(erc721a.balanceOf(to), amount);

		g = gasleft();
	}

	function testBatchSafeTransferFromGas() public {
		address to = getRandomAddress(69420);

		erc721a.safeMint(address(this), amount);

		uint256[] memory ids = new uint256[](amount);
		for(uint256 i; i < amount; i++) {
			ids[i] = i + 1;
		}

		uint256 g = gasleft();
		erc721a.batchSafeTransferFrom(address(this), to, ids);
		g -= gasleft();
		console.log("Transfer gas", g);
		console.log("Average", g / amount);

		assertEq(erc721a.balanceOf(address(this)), 0);
		assertEq(erc721a.balanceOf(to), amount);

		g = gasleft();
	}

	function onERC721Received(
		address,
		address,
		uint256,
		bytes calldata
	) external pure returns (bytes4) {
		return this.onERC721Received.selector;
	}

	function getRandom256(uint256 salt) private pure returns (uint256) {
		return uint256(keccak256(abi.encodePacked(salt)));
	}

	function getRandomAddress(uint256 salt) private pure returns (address) {
		return address(uint160(getRandom256(salt)));
	}
}
