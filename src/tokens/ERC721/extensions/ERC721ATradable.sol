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
/// Whitelists all OpenSea proxy addresses in {isApprovedForAll} and saves up to 50,000 gas for
/// each account by removing the need to {setApprovalForAll} before being able to trade on the platform.
/// @dev https://github.com/chiru-labs/ERC721A/issues/40
/// Comes at the cost of being unable to revoke the approval,
/// this makes preventing certain phishing attacks impossible.
abstract contract ERC721ATradable is ERC721A {
	/// @dev OpenSea Proxy Registry for whitelisting proxy addresses in {isApprovedForAll}.
	IProxyRegistry internal immutable proxyRegistry;

	/// @notice Constructor
	/// @dev Requirements:
	/// - `_proxyRegistry` must not be the 0 address.
	/// OpenSea proxy registry addresses:
	/// ETHEREUM MAINNET: 0xa5409ec958C83C3f309868babACA7c86DCB077c1
	/// ETHEREUM RINKEBY: 0xF57B2c51dED3A29e6891aba85459d600256Cf317
	/// @param _proxyRegistry The OpenSea proxy registry address.
	constructor(address _proxyRegistry) {
		require(_proxyRegistry != address(0), "INVALID_ADDRESS");
		proxyRegistry = IProxyRegistry(_proxyRegistry);
	}

	/// @return True if `operator` is an OpenSea proxy address or if it was approved by `owner` with {setApprovalForAll}.
	/// @inheritdoc ERC721A
	function isApprovedForAll(address owner, address operator) public view virtual override returns (bool) {
		if (proxyRegistry.proxies(owner) == operator) return true;
		return super.isApprovedForAll(owner, operator);
	}
}
