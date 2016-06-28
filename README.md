# Outside-In CDN Acceptance Test Suite [![build status](https://travis-ci.org/rhargreaves/spa-demo-test-suite.svg)](https://travis-ci.org/rhargreaves/spa-demo-test-suite)

## Requirements

Either:

1. Docker
2. Docker Compose

Or:

1. Ruby 2.3
3. Selenium

## Usage

Using Docker Compose:

```
$ docker-compose build
$ docker-compose run tests
```

If you run into trouble with tests failing as they cannot resolve internet addresses, run the following before running tests:

```
$ docker-compose down
```

Or:

Run the tests against Selenium manually (be sure to update the code to look at a local browser rather than the containerised Selenium instance)



