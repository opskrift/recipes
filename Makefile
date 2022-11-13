SRC := $(shell find {opskrift,tests} -name "*.py")

test:
	@poetry run pytest --exitfirst --hypothesis-show-statistics

format:
	@poetry run autoflake --remove-all-unused-imports -i $(SRC)
	@poetry run isort opskrift/ tests/ $(SRC)
	@poetry run black opskrift/ tests/ $(SRC)

typecheck:
	@poetry run mypy opskrift/ tests/

build-docs:
	rm -rfv docs/sources/reference
	rm -rfv docs/sources/template
	python3 docs/gen_references.py
	mkdocs build --config-file docs/mkdocs.yml

clean:
	rm -rf **/__pycache__
	rm -rf **/.ipynb_checkpoints
	rm -rf .mypy_cache
	rm -rf .hypothesis
	rm -rf .pytest_cache
