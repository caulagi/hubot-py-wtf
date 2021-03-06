# Description
#   A hubot script that finds some wtf moments in your python code
#
# Configuration:
#   HUBOT_PY_WTF_CODE_DIR Full path to the directory to check for wtf moments
#
# Commands:
#   hubot pywtf random - <Get a random wtf moment>
#   hubot pywtf bomb N - <Get N random wtf moments>
#   hubot pywtf setdir - <Set the directory for the code>
#
# Notes:
#   This scripts works only in a standard unix environment and expects
#   standard commands like find and grep to be available
#
# Author:
#   Pradip Caulagi <caulagi@gmail.com>

fs = require 'fs'
util = require 'util'
exec = require('child_process').exec

module.exports = (robot) ->
  name = "py-wtf:"
  working_dir = process.env.HUBOT_PY_WTF_CODE_DIR

  rules = [
    "find %s -type f -name '*.py' -exec grep -i 'fixme' -- {} +"
    "find %s -type f -name '*.py' -exec grep -i 'wtf' -- {} +"
    "find %s -type f -name '*.py' -exec grep 'lambda' -- {} + | grep reduce"
    "find %s -type f -name '*.py' -exec grep 'lambda' -- {} + | grep zip"
    "find %s -type f -name '*.py' -exec grep 'partial' -- {} + | grep reduce"
    "find %s -type f -name '*.py' -exec grep 'partial' -- {} + | grep filter"
    "find %s -type f -name '*.py' -exec grep 'partial' -- {} + | grep collect"
    "find %s -type f -name '*.py' -exec grep '<<' -- {} + | grep '&'"
    "find %s -type f -name '*.py' -exec grep '<<' -- {} + | grep '|'"
    "find %s -type f -name '*.py' -exec grep '>>' -- {} + | grep '&'"
    "find %s -type f -name '*.py' -exec grep '>>' -- {} + | grep '|'"
    "find %s -type f -name '*.py' -exec grep 're.compile' -- {} +"
    "find %s -type f -name '*.py' -exec grep -w 'eval' -- {} +"
  ]

  remove_rule = (index) ->
    # Remove the rule at the given index and return the array
    if index == 0?
      return rules[1..]
    else if index == rules.length?
      return rules[0..index-1]
    return rules[0...index].concat(rules[index+1..])

  random_wtf = (res) ->
    if not rules.length
      return res.reply "Good job - the code looks clean"

    index = Math.floor(Math.random() * rules.length)
    cmd = util.format(rules[index], working_dir)
    exec cmd, (err, stdout, stderr) ->
      if err?
        rules = remove_rule index
        random_wtf res
      else
        if stdout.length == 0
          rules = remove_rule index
          random_wtf res
        else
          items = (item for item in stdout.split("\n") when item.length > 0)
          res.reply res.random items

  robot.respond /pywtf random/i, (res) ->
    if not working_dir?
      return res.reply "You need to set the working directory!"
    random_wtf res

  robot.respond /pywtf bomb( (\d+))?/i, (res) ->
    if not working_dir?
      return res.reply "You need to set the working directory!"
    count = res.match[2] || 5
    random_wtf res for i in [0...count]

  robot.respond /pywtf setdir( (.*))?/i, (res) ->
    path = res.match[2]
    fs.access path, fs.R_OK, (err) ->
      if err?
        return res.reply "No such directory!"
      else
        working_dir = path
        return res.reply "ok!"
