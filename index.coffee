ASSERT = require 'assert'

_ = require 'underscore'
Q = require 'q'
REQ = require 'request'


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
            return ASSERT.equal(expected, actual, msg)
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


exports.T = (fn) ->
    test = (done) ->
        context = new exports.TestContext()

        whenDone = (err) ->
            if err then return done(err)
            context.checkCount()
            return done()

        return fn.call(context, whenDone)

    return test


exports.request = (opts) ->
    d = Q.defer()

    defaults =
        method: 'GET'
        jar: off
        followRedirect: off

    opts = if typeof opts is 'string'
        defaults.url = opts
        defaults
    else _.defaults(opts, defaults)

    REQ opts, (err, res, body) ->
        if err then return d.reject(err)

        if opts.expectStatus and res.statusCode isnt opts.expectStatus
                msg = "expected HTTP status code #{opts.expectStatus} "
                msg += "but got #{res.statusCode}"
                console.log('')
                console.log('request error:')
                console.log(msg)
                console.log('')
                console.log(res.headers)
                console.log(body)
                console.log('')
                return d.reject(new Error(msg))

        return d.resolve(res, body)
    return d.promise
