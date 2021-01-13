from numpy import array, concatenate
from functools import reduce
# Inspired by {×/⍵⌷⍤1 99⍨↑(⊢~⍥,⍤99 0⊢)⍳⍴⍵}

def RemoveFrom(a,i):   # Remove element at index i from array a
    arr = array(a)
    return list(concatenate((a[0:i],a[i+1:])))

def Times(x,y):
    return x*y
def Product(a):
    return reduce(Times,a)

def ArrayOfProduct(m):
    r = []
    for i in range(len(m)):
        r.append(Product(RemoveFrom(m,i)))
    return r

a = [5,2,1,4,3]
print(ArrayOfProduct(a))
