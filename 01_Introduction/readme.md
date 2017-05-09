# Introduction

- Write BDD style unit tests for javascript applications
- Aimed at front-end, javascript developers that:
  - are new to unit testing
  - need to get up to speed with a popular and fully-featured unit testing framework
  - have intermediate level of experience
- Setup
  - set up a development area
  - see the specRunner in action and the default reporter
- Jasmine Basic
  - create test suites and test cases
  - make assertions to test code
  - perform setup and tear-down
  - install JSCover and generate coverage reports
- Jasmine Spies
  - create test-doubles
  - stub methods
  - methods and properties of spies
  - tracking property: calls to the spy / arguments passed
- Advanced
  - create custom matchers
  - Use the jasmine clock
  - test asynchronous code

## Setup

- create two folder: 'dev' and 'test'
- download [jasmine.js](https://github.com/jasmine/jasmine#installation)
- copy lib folder and specRunner.html of jasmine-standalone to test folder
- create a 'spec' folder

```
root
  |- dev
  |- test
    |- lib
    |- spec
    - specRunner.html
```

- download [require.js](http://requirejs.org/docs/download.html#requirejs)
- create 'lib' folder under dev folder and put require.js in.
- create a new 'scripts' folder

```
root
  |- dev
    |- lib
      - require.js
    |- scripts
  |- test
    |- lib
    |- spec
    - specRunner.html
```

- create numbers.js file in scripts folder

```
/*global define*/
define(function(){
  'use strict';
  var self = {};

  console.log("numbers")

  return self;
});
```

- create main.js file in scripts folder

```
/*globals require*/
require(['numbers']);
```

- create index.html under dev folder

```
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
  </head>
  <body>
    <script data-main="scripts/main.js" src="lib/require.js"></script>
  </body>
</html>
```

```
root
  |- dev
    |- lib
      - require.js
    |- scripts
    - index.html
  |- test
    |- lib
    |- spec
    - specRunner.html
```

- install [phantom.js](http://phantomjs.org/)

```
$ brew install phantomjs
```

[sample code](./code)

[more about require.js](https://medium.com/@dd0425/javascript-require-js-8ba5b6a68d21)