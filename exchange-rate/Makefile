.PHONY: build
build:
	docker build -t exchange:latest .

.PHONY: tests
tests:
	docker run exchange:latest bundle exec ruby test/run_tests.rb