.SILENT:

include .manala/Makefile

########
# Lint #
########

## Lint - Lint collection [VERBOSE]
lint:
	$(call manala_docker_shell, ansible-lint \
		$(if $(VERBOSE), -v) \
		--force-color \
	)
.PHONY: lint

########
# Test #
########

## Test - Run all tests (but coverage)
test: test.sanity test.units test.integration
.PHONY: test

## Test - Run sanity tests [VERBOSE]
test.sanity:
	$(call manala_docker_shell, ansible-test sanity \
		--requirements \
		--venv \
		--python 3.11 \
		$(if $(VERBOSE), --verbose) \
		--color yes \
		--exclude .github/ \
		--exclude .manala/ \
	)
.PHONY: test.sanity

## Test - Run units tests [VERBOSE|COVERAGE]
test.units:
	$(call manala_docker_shell, ansible-test units \
		--requirements \
		--venv \
		--python 3.11 \
		$(if $(VERBOSE), --verbose) \
		$(if $(COVERAGE), --coverage) \
		--color yes \
	)
.PHONY: test.units

## Test - Run integration tests [VERBOSE|COVERAGE]
test.integration:
	$(call manala_docker_shell, ansible-test integration \
		--requirements \
		--venv \
		--python 3.11 \
		$(if $(VERBOSE), --verbose) \
		$(if $(COVERAGE), --coverage) \
		--color yes \
	)
.PHONY: test.integration

## Test - Run coverage [VERBOSE]
test.coverage:
	$(call manala_docker_shell, ansible-test coverage xml \
		--requirements \
		--venv \
		--python 3.11 \
		--group-by command \
		--group-by version \
		$(if $(VERBOSE), --verbose) \
		--color yes \
	)
.PHONY: test.coverage
