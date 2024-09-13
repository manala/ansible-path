.SILENT:

include .manala/Makefile

########
# Lint #
########

## Lint - Lint collection [VERBOSE]
lint: SHELL := $(MANALA_DOCKER_SHELL)
lint:
	ansible-lint \
		$(if $(VERBOSE), -v) \
		--force-color
.PHONY: lint

########
# Test #
########

## Test - Run all tests (but doc and coverage)
test: test.sanity test.units test.integration
.PHONY: test

## Test - Run sanity tests [VERBOSE]
test.sanity: SHELL := $(MANALA_DOCKER_SHELL)
test.sanity:
	ansible-test sanity \
		--requirements \
		--venv \
		--python 3.11 \
		$(if $(VERBOSE), --verbose) \
		--color yes \
		--exclude .github/ \
		--exclude .manala/
.PHONY: test.sanity

## Test - Run units tests [VERBOSE|COVERAGE]
test.units: SHELL := $(MANALA_DOCKER_SHELL)
test.units:
	ansible-test units \
		--requirements \
		--venv \
		--python 3.11 \
		$(if $(VERBOSE), --verbose) \
		$(if $(COVERAGE), --coverage) \
		--color yes
.PHONY: test.units

## Test - Run integration tests [VERBOSE|COVERAGE]
test.integration: SHELL := $(MANALA_DOCKER_SHELL)
test.integration:
	ansible-test integration \
		--requirements \
		--venv \
		--python 3.11 \
		$(if $(VERBOSE), --verbose) \
		$(if $(COVERAGE), --coverage) \
		--color yes
.PHONY: test.integration

## Test - Run documentation tests [VERBOSE]
test.doc: SHELL := $(MANALA_DOCKER_SHELL)
test.doc:
	$(foreach type,module filter, \
		$(foreach plugin,$(shell ansible-doc --list manala.path --type $(type) | cut -d " " -f 1), \
			ansible-doc \
				$(if $(VERBOSE), --verbose) \
				--type $(type) \
				$(plugin) && \
		) \
	) true
.PHONY: test.doc

## Test - Run coverage [VERBOSE]
test.coverage: SHELL := $(MANALA_DOCKER_SHELL)
test.coverage:
	ansible-test coverage xml \
		--requirements \
		--venv \
		--python 3.11 \
		--group-by command \
		--group-by version \
		$(if $(VERBOSE), --verbose) \
		--color yes
.PHONY: test.coverage

###################
# Build / Publish #
###################

COLLECTION = manala-path-*.tar.gz

## Build - Build collection
build: SHELL := $(MANALA_DOCKER_SHELL)
build:
	rm -rfv $(COLLECTION)
	ansible-galaxy collection build \
		$(if $(VERBOSE), --verbose) \
		--force
.PHONY: build

## Collection - Publish collection
publish: SHELL := $(MANALA_DOCKER_SHELL)
publish:
	ansible-galaxy collection publish $(COLLECTION) \
		$(if $(VERBOSE), --verbose)
.PHONY: publish
