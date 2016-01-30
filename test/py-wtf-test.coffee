Helper = require('hubot-test-helper')
chai = require 'chai'
expect = chai.expect
helper = new Helper('../src/py-wtf.coffee')

describe 'py-wtf', ->

  beforeEach ->
    @room = helper.createRoom()

  afterEach ->
    @room.destroy()

  describe 'setting working dir', ->

    afterEach ->
      @room.messages = []

    it 'to valid path', ->
      msg = 'hubot pywtf setdir /tmp'
      @room.user.say('alice', msg).then =>
        expect(@room.messages).to.eql [
          [ 'alice', msg ],
          [ 'hubot', '@alice ok!' ]
        ]

    it 'to invalid path', ->
      msg = 'hubot pywtf setdir /tmppp'
      @room.user.say('alice', msg).then =>
        expect(@room.messages).to.eql [
          [ 'alice', msg ],
        ]
