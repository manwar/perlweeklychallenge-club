.PHONEY: help
help:
	@grep -E '^[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
   sort | \
   awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONEY: test
test: ## run the test suite
	@python -m unittest

.PHONEY: satisfy-reqs
satisfy-reqs: ## ensure the requirements are installed
	@python -m pip install -r requirements.txt
