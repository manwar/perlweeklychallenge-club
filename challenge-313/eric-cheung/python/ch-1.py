
from collections import OrderedDict

## Example 1
## strName = "perl"
## strTyped = "perrrl"

## Example 2
## strName = "raku"
## strTyped = "rrakuuuu"

## Example 3
## strName = "python"
## strTyped = "perl"

## Example 4
strName = "coffeescript"
strTyped = "cofffeescccript"

setName = OrderedDict((charLoop, True) for charLoop in strName)
setTyped = OrderedDict((charLoop, True) for charLoop in strTyped)

print (setName == setTyped)
