# Outside-In CDN Acceptance Test Suite [![build status](https://travis-ci.org/rhargreaves/spa-demo-test-suite.svg)](https://travis-ci.org/rhargreaves/spa-demo-test-suite)

## Requirements

Install Docker & Docker Compose

* On Windows/OS X: Install Docker Toolbox - https://www.docker.com/products/docker-toolbox
* On Linux: Install Docker & Docker Compose - https://docs.docker.com/engine/installation/linux/

## Usage

Using Docker Compose:

```
$ docker-compose build
$ docker-compose run tests
```

Be sure to re-run `docker-compose build` before running the tests after a change to the code.

#### Troubleshooting

* If you are running Windows, `docker-compose run tests` will not work. Use `docker-compose up` and then press Ctrl+C when the test have ran. Use `docker-compose down` before attempting to run tests again.

* If you run into trouble with tests failing as they cannot resolve internet addresses, run `docker-compose down` before running tests

####  Alternatively...

Install Ruby 2.3 & Selenium and run the code using `rspec`. Be sure to update the code to look at a local browser rather than the containerised Selenium instance.



