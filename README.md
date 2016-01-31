# hubot-py-wtf

A hubot script that finds some wtf moments in your python code

```
user1>> hubot pywtf setdir /Users/pcaulagi/code
hubot>> ok!

user1>> hubot pywtf random
hubot>> /Users/pcaulagi/code/api.py: wq = reduce(lambda x, y: x & y, wq)

user1>> hubot pywtf random
hubot>> /Users/pcaulagi/code/utils.py: rd[j] = ((rd[j + 1] << 1) | 1) & charMatch

user1>> hubot pywtf bomb
hubot>> /Users/pcaulagi/code/patch.py:          # WTF?
hubot>> /Users/pcaulagi/code/utils.py: rd[j] = ((rd[j + 1] << 1) | 1) & charMatch
hubot>> /Users/pcaulagi/code/patch.py:              ((last_rd[j + 1] | last_rd[j]) << 1) | 1) | last_rd[j + 1]
hubot>> /Users/pcaulagi/code/staff.py:        form = wraps(FilterStaffForm)(partial(FilterStaffForm, user=request.user))
hubot>> /Users/pcaulagi/code/api.py:        wq = reduce(lambda x, y: x & y, wq)
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
