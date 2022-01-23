// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@solmate/src/utils/ReentrancyGuard.sol";
import "./ERC721A.sol";

// solhint-disable no-empty-blocks

/// @author @DaniPopes
/// @notice Simple ERC721A Implementation for testing purposes only.
/// Do not use in production.
contract ExampleERC721A is ERC721A, Ownable, ReentrancyGuard {
	constructor(
		string memory _name,
		string memory _symbol,
		uint256 _maxBatchSize,
		string memory _baseURI
	) payable ERC721A(_name, _symbol, _maxBatchSize) {
		baseURI = _baseURI;
	}

	string public baseURI;

	function setBaseURI(string calldata _baseURI) external {
		baseURI = _baseURI;
	}

	function tokenURI(uint256 id) public view override returns (string memory) {
		string memory _baseURI = baseURI;
		return bytes(_baseURI).length == 0 ? "" : string(abi.encodePacked(_baseURI, toString(id)));
	}

	function idsOfOwner(address owner) external view returns (uint256[] memory) {
		return _idsOfOwner(owner);
	}

	function exists(uint256 tokenId) public view returns (bool) {
		return _exists(tokenId);
	}

	function safeMint(address to, uint256 quantity) public payable {
		_safeMint(to, quantity);
	}
}
