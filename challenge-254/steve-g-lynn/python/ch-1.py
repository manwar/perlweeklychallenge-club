
# Python 1.4 beta on DOSBOX

def three_power(n):
 n=n**(1.0/3.0)
 return (n==int(n))
 
print three_power(27) #1
print three_power(0) #1
print three_power(6) #0
 
