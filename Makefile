SOURCES = src/prelude.smt2.md src/lemmas.k.md src/storage.k.md src/specs.md

specs: dapp
	klab build

dapp:
	git submodule sync --recursive
	git submodule update --init --recursive
	cd code/ && dapp --use solc:0.4.11 build && cd ../

.PHONY: clean
clean:
	cd code && dapp clean
	rm -rf out/
