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

## Test - Run all tests (but coverage)
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
