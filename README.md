Test Tools
==========

A set of Node.js application testing tools we use at
[Fireworks Project](http://www.fireworksproject.com).
We use [Mocha](https://github.com/visionmedia/mocha)
for most of our testing, but you should find these tools useful for most of the
Node.js automated testing tools out there.

## Installation
Add 'test-tools' entry into the `package.json` file of your project or install it with npm:

    npm install test-tools

## Usage
There are no command line utilities as part of this package.


## API

### ::test()
A function used to create wrapped test methods which can be passed into test
frameworks that which expect functions to be passed in. This is useful for a
couple reasons:

* Bind the test function to a utility object for easy access to assertion functions.
* Keep an assertion count and check it when the test is over.

Here's an example useing Mocha:

```JavaScript
var TEST = require('test-tools');
var T = TEST.test;

describe('something', function () {
    it('should do something', T(function (done) {
        // If anything more or less than 9 assertions are run, then
        // an assertion error will be thrown.
        this.expectCount(9);

        // Asynchronous testing is done as usual
        // but *don't forget to call done()*
        setTimeout(function () {
            this.assert();
            this.equal();
            this.notEqual();
            this.strictEqual();
            this.notStrictEqual();
            this.deepEqual();
            this.notDeepEqual();
            return done();
        }, 12);

        this.throws(function () {
            throw new Error('testing');
        });

        this.doesNotThrow(function () { return; });

        // if `done()` is not called in an asynchronous closure, like it
        // was above, then make sure it is called here instead.
        return;
    }));
});
```

All the assertion methods bound to `this` are proxied to the Node.js assertion
methods of the same name.  For more info on their usage, consult the
[Node.js docs](http://nodejs.org/api/assert.html).

### Underscore
[Underscore.js](http://documentcloud.github.com/underscore/)
is exposed as `_`, `Underscore`, `UN` and `underscore`.

## Testing
Run the tests with:

    rake test

Of course you'll need to
[install Node.js](http://nodejs.org/) and
[Rake](http://rake.rubyforge.org/) first.
