ASSERT = require 'assert'


# Constructor for the context object that test functions are bound to when
# using ::test() to create them.
class exports.TestContext
    constructor: ->
        @assertionCount = 0

    expectCount: (n) ->
        @expectedAssertions = n
        return

    checkCount: ->
        actual = @assertionCount
        expected = @expectedAssertions
        if typeof expected is 'number'
            msg = "expected #{expected} assertions but got #{actual}"
            return ASSERT.equal(actual, expected, msg)
        return

    assert: (val, msg) ->
        @assertionCount += 1
        return ASSERT(val, msg)

    equal: (actual, expected, msg) ->
        @assertionCount += 1
        return ASSERT.equal(actual, expected, msg)

    notEqual: (actual, expected, msg) ->
        @assertionCount += 1
        return ASSERT.notEqual(actual, expected, msg)

    strictEqual: (actual, expected, msg) ->
        @assertionCount += 1
        return ASSERT.strictEqual(actual, expected, msg)

    notStrictEqual: (actual, expected, msg) ->
        @assertionCount += 1
        return ASSERT.notStrictEqual(actual, expected, msg)

    deepEqual: (actual, expected, msg) ->
        @assertionCount += 1
        return ASSERT.deepEqual(actual, expected, msg)

    notDeepEqual: (actual, expected, msg) ->
        @assertionCount += 1
        return ASSERT.notDeepEqual(actual, expected, msg)

    throws: (block, err, msg) ->
        @assertionCount += 1
        return ASSERT.throws(block, err, msg)

    doesNotThrow: (block, err, msg) ->
        @assertionCount += 1
        return ASSERT.doesNotThrow(block, err, msg)


# Create a test function that will bind to the Test class (so that `this` is an instance of the class Test).
# The retured test function with automatically check the assertion count when done() is called.
# GOTCHA: You must call done() to end the test, otherwise it will hang.
exports.test = (fn) ->
    test = (done) ->
        context = new exports.TestContext()

        whenDone = (err) ->
            if err then return done(err)
            context.checkCount()
            return done()

        return fn.call(context, whenDone)

    return test


# Expose Underscore as `_` and `underscore`
exports._ = exports.underscore = exports.Underscore = exports.UN = require 'underscore'
