
build:
	docker-compose build

test-all:
	docker-compose run tests

test-site-loads:
	docker-compose run tests bash -c "DO_NOT_HIT_CDN=1 rspec --tag loads"

test-site-perf:
	docker-compose run tests bash -c "DO_NOT_HIT_CDN=1 rspec --tag loads --tag perf"

test-cdn-perf:
	docker-compose run tests bash -c "rspec --tag loads --tag perf"

test-cdn-counter:
	docker-compose run tests bash -c "rspec --tag loads --tag perf --tag counter"

test-cdn:
	docker-compose run tests bash -c "DO_NOT_HIT_ORIGIN=1 rspec"
