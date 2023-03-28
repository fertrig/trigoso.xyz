---
title: "Angular $http service that returns same object"
date: 2015-06-01
draft: false
slug: angular-http-service-returns-same-object
---

Here's an angular service that exposes a *read* function. The first time *read* is called, the service will call an API (using $http) to get some data. The service will convert this data to an object which will be stored in memory. Subsequent *read* calls will return the object stored in memory. This will avoid multiple API calls to get the same object. It will also enable multiple views to bind to the same object.

Here's an initial implementation of such service:

```Javascript
var loaded = false,
	data = [];

function read() {
	if (loaded) {
		return $q.when(data);
	}
	else {
		return $http.post(apiPath)
			.then(function(res) {
				for (var i = 0; i &lt; res.data.length; i++) {
					data.push(res.data[i]);
				}

				return data;
			})
	}
}
```

However, this approach still makes multiple API calls if multiple calls occur while the client is waiting for the data to comeback from the server.

Here's an implementation that only makes one API call regardless of the timing of the callers.

```Javascript
var loaded = false,
	calling = false,
	callers = [],
	data = [];

function read() {
	if (loaded) {
		return $q.when(data);
	}
	else if (calling) {
		var deferred = $q.defer();
		callers.push(deferred);
		return deferred.promise;
	}
	else {
		calling = true;
		return $http.post(apiPath)
			.then(function(res) {
				for (var i = 0; i &lt; res.data.length; i++) {
					data.push(res.data[i]);
				}

				loaded = true;
				calling = false;

				for (var i = 0; i &lt; callers.length; i++) {
					callers[i].resolve(data);
				}

				callers = [];

				return data;
			})
	}
}
```

We just need to wrap that *read* function in an angular service. Once it is a service, controllers and directives can access it and they will all bind to the same object.

I wrote a sample app to prove the pattern. The source code is in github:

https://github.com/fertrig/ng-read-once-sample

Also available to deploy to Heroku:

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy?template=https://github.com/fertrig/ng-read-once-sample)

  