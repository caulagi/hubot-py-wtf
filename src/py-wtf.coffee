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
#   standard commands like find and egrep to be available
#
# Author:
#   Pradip Caulagi <caulagi@gmail.com>

fs = require 'fs'
util = require 'util'
exec = require('child_process').exec

module.exports = (robot) ->
  name = "py-wtf:"
  working_dir = process.env.HUBOT_PY_WTF_CODE_DIR

  if working_dir?
    robot.logger.info(name, working_dir)
  else
    robot.logger.warning(name, "You need to set the working dir before the script can show its magic")

  rules = [
    "find %s -type f -name '*.py' -exec grep -i 'fixme' -- {} +"
    "find %s -type f -name '*.py' -exec grep 'lambda' -- {} + | grep reduce"
    "find %s -type f -name '*.py' -exec grep '<<' -- {} + | grep '&'"
    "find %s -type f -name '*.py' -exec grep '<<' -- {} + | grep '|'"
    "find %s -type f -name '*.py' -exec grep '>>' -- {} + | grep '&'"
    "find %s -type f -name '*.py' -exec grep '>>' -- {} + | grep '|'"
  ]

  robot.respond /pywtf random/i, (res) ->
    if not working_dir?
      return res.reply "You need to set the working directory!"

    rule = rules[ Math.floor(Math.random() * rules.length) ]
    cmd = util.format(rule, working_dir)
    robot.logger.info(cmd)
    exec cmd, (err, stdout, stderr) ->
      if err?
        return res.reply util.format("Error executing command: %s", err)
      else
        return res.reply res.random stdout.split("\n")

  robot.respond /pywtf bomb( (\d+))?/i, (res) ->
    count = res.match[2] || 5
    res.reply "!"

  robot.respond /pywtf setdir( (.*))?/i, (res) ->
    path = res.match[2]
    robot.logger.debug(name, path)
    fs.access path, fs.R_OK, (err) ->
      if err?
        return res.reply "No such directory!"
      else
        working_dir = path
        return res.reply "ok!"
