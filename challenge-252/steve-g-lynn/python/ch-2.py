# python 1.4 beta on DOSBOX

def unique_sum_zero(n):
 retval=[]
 if ((n % 2) > 0):
   retval.append(0)
 for i in range(n/2):
   retval.append(-(i+1))
   retval.append(i+1)
 return retval
 
print unique_sum_zero(5) #[0,-1,1,-2,2]
print unique_sum_zero(3) #[0,-1,1]
print unique_sum_zero(1) #[0]

