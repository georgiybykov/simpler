# Simpler

**Simpler** is a little web framework written in [Ruby](https://www.ruby-lang.org) language. It's compatible with [Rack](https://rack.github.io) interface and intended to **learn** how web frameworks work in general.

## The application overview

Simpler application is a singleton instance of the `Simpler::Application` class. For convenience it can be obtained by calling `Simpler.application` method. This instance holds all the routes and responds to `call` method which is required by the Rack interface.


__________________________

### Examples:

#### Create a new test
```bigquery
curl -X POST "http://localhost:9292/tests/mytestname/11" -d ''

where:
'mytestname' #=> the title of the test
'11' #=> the level of the test
```

#### Show the list of the tests
```bigquery
curl --url "http://localhost:9292/tests" -i
```

#### Show the information of the test by `test_id`
```bigquery
curl --url "http://localhost:9292/tests/2" -i
```

#### Show the `text/plain` response
```bigquery
curl --url "http://localhost:9292/tests/info" -i
```

#### If the route does not match any, you will see an error:
```bigquery
HTTP/1.1 404 Not Found
Content-Type: text/plain
Content-Length: 15
Server: WEBrick/1.6.0 (Ruby/2.7.2/2020-10-01)
Date: Tue, 09 Feb 2021 00:17:48 GMT
Connection: Keep-Alive

Not Found: /error_url
```