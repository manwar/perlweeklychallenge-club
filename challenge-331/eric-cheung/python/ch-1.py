
import re

## strInput = "The Weekly Challenge"  ## Example 1
## strInput = "   Hello   World    "  ## Example 2
strInput = "Let's begin the fun"  ## Example 3

strOutput = re.sub(r"\s+", " ", strInput).strip()

arrOutput = [strLoop for strLoop in strOutput.split(" ") if strLoop]

print (len(arrOutput[-1]))
