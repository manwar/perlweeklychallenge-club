# Two numbers (A, B) are their binary complements
# They will sum up to a N: (A + B = N)
#  where N = (2⋆k)-1,
#  where k is the number of bits required to represent A
#
# So first we find how many bits are required (A in log_2 rounded up)
# Then we find the value of N
# And we subtract from N our A
F←(⌈⌾(2⊸⋆⁼1⊸+))⊸-
2 = F 5
7 = F 8
