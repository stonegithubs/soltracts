# Forge Template

A template for quickly getting started with forge.

## Getting Started

```bash
mkdir my-project
cd my-project
forge init --template https://github.com/DaniPopes/forge-template

# initialize submodule dependencies
git submodule update --init --recursive 

# install development dependencies
yarn
```

## Features

### Testing Utilities

Includes common testing contracts like `Hevm.sol` and `Console.sol`, as well as a `Utilities.sol` contract with common testing methods like creating users with an initial balance.

### Dependencies

`ds-test` and `solmate` are already installed.

### Scripts

Pre-configured `prettier` and `solhint`. Yarn is used for linting, make for everything else.

```bash
# all are configured to run the solc optimizer with 100000 runs
make build
make test
# test with verbosity 3
make trace
make clean
make snapshot
# runs yarn lint
make lint

yarn lint
# doesn't write
yarn lint:check
```

## Acknowledgements

Inspired by [@Gakonst](https://github.com/gakonst/)'s and [@FrankieIsLost](https://github.com/FrankieIsLost/forge-template)'s forge templates.