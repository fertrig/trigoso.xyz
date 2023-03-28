---
title: "Development Grunt Tasks in a Heroku Production Environment"
date: 2014-02-24
draft: false
slug: grunt-tasks-in-heroku
---

We ran into a bit of a conflict between Gruntfile.js and package.json. The package.json file defines the npm packages that are used by the application and by Grunt. However, some of the grunt tasks only make sense to run in a development or test environment, but not in a production environment. Our package.json file was able to make this distinction but our Gruntfile.js wasn't.

Looking at the code, our package.json had the dev packages declared inside *devDependencies*:

```Javascript
// In package.json
...
"devDependencies": {
    "jasmine-node": "1.5.X",
    "grunt-contrib-jshint": "~0.6.0",
    ...
}
```

But, our Gruntfile.js didn't distinguish between a dev or a production environment. It just declared tasks that always had to be loaded:

```Javascript
// In Gruntfile.js
...
grunt.loadNpmTasks('grunt-contrib-jshint');
grunt.loadNpmTasks('grunt-jasmine-node');
...
```
This setup failed when deploying to production because Grunt was trying to load tasks whose modules were not installed because npm doesn't install dev dependencies in production.

We came up with a quick fix to this issue by reading the .env file. Since we are using Heroku, our dev boxes have the .env file, and they define the environment they are running:

```Javascript
// In .env
...
NODE_ENV=development
...
```

Thus, we wrote some code in Gruntfile.js to read the .env file:

```Javascript
// In Gruntfile.js
...
function isDevelopmentEnvironment() {
    return grunt.file.exists('.env') &amp;&amp; 
           grunt.file.read('.env').indexOf('NODE_ENV=development') !== -1;
}

if (isDevelopmentEnvironment()) {
    grunt.loadNpmTasks('grunt-contrib-jshint');
    grunt.loadNpmTasks('grunt-jasmine-node');
    ...
}
```

And that did the trick, we can now deploy to production and the development Grunt tasks will only load in a development environment.