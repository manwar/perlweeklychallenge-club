
# Python 1.4 beta on DOSBOX

def special_numbers( ints ):
 retval=0
 n=len(ints)
 for i in range(n):
   if ((n % (i+1)) == 0):
     retval = retval + (ints[i]*ints[i])
 return retval
 
print special_numbers([1,2,3,4])
print special_numbers([2,7,1,19,18,3])

