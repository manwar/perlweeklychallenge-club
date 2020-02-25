#!/usr/bin/python

import array as arr
import numpy as np 

a = arr.array('i', [10,4,1,8,12,3])
b = [10,4,1,8,12,3]
print(a)
print(b)

print(a[slice(0,2,5)])

# -------------------------------------------------  
B = np.array(b) 

R = B[np.array([0,2,5])]
R.sort()
B[np.array([0,2,5])] = R
print(" Result: ", R )
print(" Result: ", B )

# -------------------------------------------------  
# Create a sequence of integers from 10 to 1 with a step of -2 
# a = np.arange(10, 1, -2)  
# print("\n A sequential array with a negative step: \n",a) 
  
# Indexes are specified inside the np.array method. 
# newarr = a[np.array([3, 1, 2 ])] 
# print("\n Elements at these indices are:\n",newarr) 

