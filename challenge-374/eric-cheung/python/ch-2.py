
import re

## strInput = "6777133339"  ## Example 1
## strInput = "1200034"  ## Example 2
## strInput = "44221155"  ## Example 3
## strInput = "88888"  ## Example 4
strInput = "11122233"  ## Example 5

objBlock = [objMatch.group(0) for objMatch in re.finditer(r'(\d)\1*', strInput)]
    
if not objBlock:
    print ("")
else:    
    print (max(objBlock, key = lambda row: int(row)))
