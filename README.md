# hubot-py-wtf
![travis status](https://travis-ci.org/caulagi/hubot-py-wtf.svg?branch=master)

A hubot script that finds some wtf moments in your python code

```
user1>> hubot pywtf setdir /tmp/zcxv
hubot>> No such directory!

user1>> hubot pywtf setdir /Users/pcaulagi/code
hubot>> ok!

user1>> hubot pywtf random
hubot>> /Users/pcaulagi/code/api.py: wq = reduce(lambda x, y: x & y, wq)

user1>> hubot pywtf random
hubot>> /Users/pcaulagi/code/utils.py: rd[j] = ((rd[j + 1] << 1) | 1) & charMatch
```

## Installation

In hubot project repo, run:

`npm install hubot-py-wtf --save`

Then add **hubot-py-wtf** to your `external-scripts.json`:

```json
[
  "hubot-py-wtf"
]
```
