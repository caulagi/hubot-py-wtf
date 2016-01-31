Helper = require('hubot-test-helper')
chai = require 'chai'
process = require 'process'
util = require 'util'
expect = chai.expect
helper = new Helper('../src/py-wtf.coffee')

waitForReplies = (number, room, callback) ->
  setTimeout(->
    if room && room.messages.length >= number
      callback(room)
    else
      waitForReplies(number, room, callback)
  )

describe 'py-wtf:', ->

  room = helper.createRoom()

  beforeEach ->
    room.messages = []

  describe 'setting working dir', ->

    it 'to invalid path should fail', (done) ->
      room.user.say 'alice', '@hubot pywtf setdir /invalid'
      waitForReplies 2, room, ->
        expect(room.messages[1]).to.eql [ 'hubot', '@alice No such directory!' ]
        done()

    it 'to valid path should succeed', ->
      room.user.say 'alice', '@hubot pywtf setdir /tmp'
      waitForReplies 2, room, ->
        expect(room.messages[1]).to.eql [ 'hubot', '@alice ok!' ]
        done()
