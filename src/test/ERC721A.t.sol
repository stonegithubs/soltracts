// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import { DSTest } from "ds-test/test.sol";
import { Utilities } from "./utils/Utilities.sol";
import { console } from "./utils/Console.sol";
import { Hevm } from "./utils/Hevm.sol";
import { ExampleERC721A } from "../tokens/ERC721/ExampleERC721A.sol";

contract TestERC721A is DSTest {
	Hevm internal immutable vm = Hevm(HEVM_ADDRESS);

	uint256 internal constant maxBatchSize = 5;

	ExampleERC721A internal erc721a;

	function setUp() public {
		erc721a = new ExampleERC721A("testname", "testsymbol", maxBatchSize, "https://example.com/12345/");
	}

	function testDeployGas(uint256 rnd) public {
		unchecked {
			new ExampleERC721A("abcdefg", "xyz", (getRandom256(rnd) % 100) + 1, "https://example.com/12345/");
		}
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

	function testSafeMintGas(uint256 _amount) public {
		unchecked {
			uint256 amount_ = _amount % maxBatchSize;
			if (amount_ == 0) amount_ = 1;
			erc721a.safeMint(address(1), amount_);
		}
	}

	function testSafeTransferFromGas() public {
		vm.startPrank(address(1));
		erc721a.safeMint(address(1), 2);
		erc721a.safeTransferFrom(address(1), address(2), 1);
		erc721a.safeTransferFrom(address(1), address(2), 1);
	}

	function testTransferFromGas() public {
		vm.startPrank(address(1));
		erc721a.safeMint(address(1), 2);
		erc721a.transferFrom(address(1), address(2), 1);
		erc721a.transferFrom(address(1), address(2), 1);
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
