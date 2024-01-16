
# Python 1.4 beta on DOSBOX

import string

def concatenation_value( ints ):
  retval=0
  for i in range(int(len(ints)/2)):
    concat = str(ints[i])+str(ints[len(ints)-i-1])
    retval = retval+string.atoi(concat)
  if ((len(ints) % 2) ==1):
    retval = retval + ints[ len(ints)/2 ] 
  return retval
  
print concatenation_value( [6,12,25,1] ) #1286
print concatenation_value( [10,7,31,5,2,2] ) #489
print concatenation_value( [1,2,10] ) #112

