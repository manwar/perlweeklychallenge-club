
import numpy as np

nIndxMax = 100

## Example 1
## arrInput = ["e", "m", "u", "g"]
## charTarget = "b"

## Example 2
## arrInput = ["d", "c", "e", "f"]
## charTarget = "a"

## Example 3
## arrInput = ["j", "a", "r"]
## charTarget = "o"

## Example 4
## arrInput = ["d", "c", "a", "f"]
## charTarget = "a"

## Example 5
arrInput = ["t", "g", "a", "l"]
charTarget = "v"

arrOutput = [ord(charloop) - ord(charTarget) if charloop > charTarget else nIndxMax for charloop in arrInput]

## print (arrOutput)
## print (np.argmin(arrOutput))
print (arrInput[np.argmin(arrOutput)])
