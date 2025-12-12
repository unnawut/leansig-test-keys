REPO_URL := https://github.com/leanEthereum/leanSpec
REPO_DIR := leanSpec

.PHONY: install test prod release clean help

help:
	@echo "Usage:"
	@echo "  make install - Clone leanSpec repository"
	@echo "  make test    - Generate keys for test scheme"
	@echo "  make prod    - Generate keys for prod scheme"
	@echo "  make release - Generate keys and create tar.gz archives (test_scheme.tar.gz, prod_scheme.tar.gz)"
	@echo "  make clean   - Remove cloned leanSpec repository and release folder"

install:
	@if [ -d "$(REPO_DIR)" ]; then \
		echo "==> $(REPO_DIR) already exists, skipping..."; \
	else \
		echo "==> Cloning repository..."; \
		git clone $(REPO_URL); \
	fi

test: install
	@echo "==> Generating keys for test scheme"
	cd $(REPO_DIR) && uv run python -m consensus_testing.keys --scheme test
	@echo "==> Moving generated files to test_scheme/"
	mkdir -p test_scheme
	cp -r $(REPO_DIR)/test_scheme/* test_scheme/
	@echo "==> Done! Keys generated in test_scheme/ folder"

prod: install
	@echo "==> Generating keys for prod scheme"
	cd $(REPO_DIR) && uv run python -m consensus_testing.keys --scheme prod
	@echo "==> Moving generated files to prod_scheme/"
	mkdir -p prod_scheme
	cp -r $(REPO_DIR)/prod_scheme/* prod_scheme/
	@echo "==> Done! Keys generated in prod_scheme/ folder"

release: test prod
	# Create release folder
	@echo "==> Creating release folder..."
	mkdir -p release

	# Compress the key files
	@echo "==> Compressing test scheme keys..."
	tar -czf release/test_scheme.tar.gz test_scheme/
	@echo "==> Compressing prod scheme keys..."
	tar -czf release/prod_scheme.tar.gz prod_scheme/

	# Success message
	@echo "==> Done! Archives created in release/ folder:"
	@echo "    - test_scheme.tar.gz"
	@echo "    - prod_scheme.tar.gz"

clean:
	@echo "==> Removing $(REPO_DIR)..."
	rm -rf $(REPO_DIR)
	@echo "==> Removing release folder..."
	rm -rf release
