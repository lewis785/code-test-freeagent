.PHONY: console
console:
	docker-compose run exchange-rate bash -c "irb -I lib -r ./lib/currency_exchange.rb"

.PHONY: generate_documentation
generate_documentation:
	docker-compose run exchange-rate bash -c "yard doc --plugin yard-tomdoc"

.PHONY: tests
tests:
	docker-compose run exchange-rate bundle exec ruby test/run_tests.rb

