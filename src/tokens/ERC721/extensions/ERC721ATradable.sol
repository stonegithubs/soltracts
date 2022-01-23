// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { ERC721A } from "../ERC721A.sol";

/// @author @DaniPopes
/// @notice OpenSea proxy registry interface
interface IProxyRegistry {
	function proxies(address) external view returns (address);
}

/// @author @DaniPopes
/// @notice ERC721A extension, inspired by @ProjectOpenSea's opensea-creatures (ERC721Tradable).
/// Whitelists all OpenSea proxy addresses in {isApprovedForAll} to remove the {setApprovalForAll}
/// transaction before trading and saves up to 50,000 gas for each account at the cost of ~15,000
/// extra deployment gas.
abstract contract ERC721ATradable is ERC721A {
	/// @dev OpenSea Proxy Registry for whitelisting proxy addresses in {isApprovedForAll}.
	IProxyRegistry internal immutable proxyRegistry;

	/// @notice Constructor
	/// @dev Requirements:
	/// - `_maxBatchSize` must not be 0.
	/// - `_proxyRegistry` must not be the 0 address.
	/// OpenSea proxy registry addresses:
	/// ETHEREUM MAINNET: 0xa5409ec958C83C3f309868babACA7c86DCB077c1
	/// ETHEREUM RINKEBY: 0xF57B2c51dED3A29e6891aba85459d600256Cf317
	/// @param _name The collection name.
	/// @param _symbol The collection symbol.
	/// @param _maxBatchSize The max mint per {_mint} call.
	/// @param _proxyRegistry The OpenSea proxy registry address.
	constructor(
		string memory _name,
		string memory _symbol,
		uint256 _maxBatchSize,
		address _proxyRegistry
	) ERC721A(_name, _symbol, _maxBatchSize) {
		proxyRegistry = IProxyRegistry(_proxyRegistry);
	}

	/// @return True if `operator` is an OpenSea proxy address or if it was approved by `owner` with {setApprovalForAll}.
	/// @inheritdoc ERC721A
	function isApprovedForAll(address owner, address operator) public view virtual override returns (bool) {
		if (address(proxyRegistry.proxies(owner)) == operator) return true;
		return super.isApprovedForAll(owner, operator);
	}
}
