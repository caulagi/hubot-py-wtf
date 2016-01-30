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

    it 'to valid path', ->
      @room.user.say('alice', 'hubot pywtf setdir /tmp').then =>
        expect(@room.messages[1]).to.eql [ 'hubot', '@alice ok!' ]
