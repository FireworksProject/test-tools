PATH = require 'path'
ASSERT = assert = require 'assert'

{equal, strictEqual} = ASSERT

describe 'test constructor', ->
    TEST = require '../dist/'

    ASSERT_equal = ASSERT.equal
    ASSERT_notEqual = ASSERT.notEqual
    ASSERT_strictEqual = ASSERT.strictEqual
    ASSERT_notStrictEqual = ASSERT.notStrictEqual
    ASSERT_deepEqual = ASSERT.deepEqual
    ASSERT_notDeepEqual = ASSERT.notDeepEqual
    ASSERT_throws = ASSERT.throws
    ASSERT_doesNotThrow = ASSERT.doesNotThrow

    afterEach ->
        ASSERT.equal = ASSERT_equal
        ASSERT.notEqual = ASSERT_notEqual
        ASSERT.strictEqual = ASSERT_strictEqual
        ASSERT.notStrictEqual = ASSERT_notStrictEqual
        ASSERT.deepEqual = ASSERT_deepEqual
        ASSERT.notDeepEqual = ASSERT_notDeepEqual
        ASSERT.throws = ASSERT_throws
        ASSERT.doesNotThrow = ASSERT_doesNotThrow
        return


    it 'should bind assert', ->
        test = TEST.test (done) ->
            err = null
            try
                @assert(true, 'message')
            catch err1
                err = err1
            equal(null, err, 'first assert failed')

            err = {}
            try
                @assert(false, 'message')
            catch err2
                err = err2

            equal('AssertionError', err.name, 'first assert passed?')
            equal('message', err.message, 'error message')
            return done()

        test ->
        return


    it 'should bind assert.equal', ->
        ran = no

        ASSERT.equal = (actual, expected, message) ->
            equal('a', actual, 'actual')
            equal('b', expected, 'expected')
            equal('msg', message, 'message')
            ran = yes
            return

        test = TEST.test (done) ->
            @equal('a', 'b', 'msg')
            return done()

        test ->
        equal(ran, yes, 'ran')
        return


    it 'should bind assert.notEqual', ->
        ran = no

        ASSERT.notEqual = (actual, expected, message) ->
            equal('a', actual, 'actual')
            equal('b', expected, 'expected')
            equal('msg', message, 'message')
            ran = yes
            return

        test = TEST.test (done) ->
            @notEqual('a', 'b', 'msg')
            return done()

        test ->
        equal(ran, yes, 'ran')
        return


    it 'should bind assert.strictEqual', ->
        ran = no

        ASSERT.strictEqual = (actual, expected, message) ->
            equal(actual, 'a', 'actual')
            equal(expected, 'b', 'expected')
            equal(message, 'msg', 'message')
            ran = yes
            return

        test = TEST.test (done) ->
            @strictEqual('a', 'b', 'msg')
            return done()

        test ->
        equal(ran, yes, 'ran')
        return


    it 'should bind assert.notStrictEqual', ->
        ran = no

        ASSERT.notStrictEqual = (actual, expected, message) ->
            equal(actual, 'a', 'actual')
            equal(expected, 'b', 'expected')
            equal(message, 'msg', 'message')
            ran = yes
            return

        test = TEST.test (done) ->
            @notStrictEqual('a', 'b', 'msg')
            return done()

        test ->
        equal(ran, yes, 'ran')
        return


    it 'should bind assert.deepEqual', ->
        ran = no

        ASSERT.deepEqual = (actual, expected, message) ->
            equal('a', actual, 'actual')
            equal('b', expected, 'expected')
            equal('msg', message, 'message')
            ran = yes
            return

        test = TEST.test (done) ->
            @deepEqual('a', 'b', 'msg')
            return done()

        test ->
        equal(ran, yes, 'ran')
        return


    it 'should bind assert.notDeepEqual', ->
        ran = no

        ASSERT.notDeepEqual = (actual, expected, message) ->
            equal('a', actual, 'actual')
            equal('b', expected, 'expected')
            equal('msg', message, 'message')
            ran = yes
            return

        test = TEST.test (done) ->
            @notDeepEqual('a', 'b', 'msg')
            return done()

        test ->
        equal(ran, yes, 'ran')
        return


    it 'should bind assert.throws', ->
        ran = no

        ASSERT.throws = (block, err, message) ->
            equal('a', block, 'actual')
            equal('b', err, 'expected')
            equal('msg', message, 'message')
            ran = yes
            return

        test = TEST.test (done) ->
            @throws('a', 'b', 'msg')
            return done()

        test ->
        equal(ran, yes, 'ran')
        return


    it 'should bind assert.doesNotThrow', ->
        ran = no

        ASSERT.doesNotThrow = (block, err, message) ->
            equal('a', block, 'actual')
            equal('b', err, 'expected')
            equal('msg', message, 'message')
            ran = yes
            return

        test = TEST.test (done) ->
            @doesNotThrow('a', 'b', 'msg')
            return done()

        test ->
        equal(ran, yes, 'ran')
        return

    it 'should check counts', ->
        pass = TEST.test (done) ->
            @expectCount(9)
            @assert(true)
            @equal(1, 1)
            @notEqual(1, 2)
            @strictEqual(1, 1)
            @notStrictEqual(1, 2)
            @deepEqual({foo: 1}, {foo: 1})
            @notDeepEqual({foo: 1}, {foo: 2})

            @throws ->
                throw new Error('testing')

            @doesNotThrow ->
                return true

            return done()

        passErr = null
        try
            pass ->
        catch err1
            passErr = err1

        equal(passErr, null)

        fail = TEST.test (done) ->
            @expectCount(10)
            @assert(true)
            @equal(1, 1)
            @notEqual(1, 2)
            @strictEqual(1, 1)
            @notStrictEqual(1, 2)
            @deepEqual({foo: 1}, {foo: 1})
            @notDeepEqual({foo: 1}, {foo: 2})

            @throws ->
                throw new Error('testing')

            @doesNotThrow ->
                return true

            return done()

        failErr = {}
        try
            fail ->
        catch err2
            failErr = err2

        equal(failErr.name, 'AssertionError')
        equal(failErr.message, 'expected 10 assertions but got 9')
        equal(failErr.expected, 10)
        equal(failErr.actual, 9)
        return

    return


describe 'expose underscore', ->
    TEST = require '../dist/'
    UN = require '../dist/node_modules/underscore/underscore'

    it 'should expose `_` and `underscore`', ->
        strictEqual(TEST._, UN, '_')
        strictEqual(TEST.underscore, UN, 'underscore')
        return

    return
