
# Python 1.4 beta on DOSBOX

import string

def split_strings(arrStr, sep):
 retval=[] #array to be returned
 for str in arrStr:
  str_split=string.splitfields( str, sep )
  for item in str_split:
   if (item != ""):
    retval.append(item)
 return retval
 
print split_strings(("one.two.three","four.five","six"),".")
#['one','two','three','four','five','six']

print split_strings(("$perl$$","$$raku$"),"$")
#['perl','raku']
  
