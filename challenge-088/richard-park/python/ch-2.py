# Inspired by {0∊⍴⍵:⍬ ⋄ (1⌷⍵),∇⍉⌽1↓⍵}
from numpy import concatenate, transpose

def Reverse(a):
    return list(reversed(a))

def SpiralMatrix(m):
    if 1==len(m):
        return m[0:1]
    else:
        return concatenate((m[0:1],SpiralMatrix(transpose(list(map(Reverse,m[1:]))))),axis=1)

m = [[1,2,3],[4,5,6],[7,8,9]]

print(list(list(SpiralMatrix(m))[0]))



