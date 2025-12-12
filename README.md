# leansig-test-keys

**Do not use these keys in production.** Pre-generated [leanSig](https://github.com/leanEthereum/leanSig/) keys for quicker test preparation.

## Usage

This repository provides a Makefile with commands to generate leanSig keys for different schemes, suitable for usage in [leanSpec](https://github.com/leanEthereum/leanSpec/) testing:

```bash
make help     # Display available commands
make install  # Clone leanSpec repository
make test     # Generate keys for test scheme
make prod     # Generate keys for prod scheme
make release  # Generate keys and create tar.gz archives (test_scheme.tar.gz, prod_scheme.tar.gz)
make clean    # Remove cloned leanSpec repository and release folder
```

## Examples

Generate test scheme keys:
```bash
# The generated keys will be in `test_schema/` directory.
make test
```

Generate production scheme keys:
```bash
# The generated keys will be in `prod_schema/` directory.
make prod
```

## Preparing a release

Create release archives:
```bash
make release
```

Use the output files (`.tar.gz` files) in [`release/`](./release/) folder to publish a new release.
