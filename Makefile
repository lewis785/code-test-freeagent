.PHONY: tests
tests:
	docker-compose run exchange-rate bundle exec ruby test/run_tests.rb
