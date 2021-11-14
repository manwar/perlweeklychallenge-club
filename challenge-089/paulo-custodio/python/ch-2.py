#!/usr/bin/env python3

# Challenge 089

# TASK #2 > Magical Matrix
# Submitted by: Mohammad S Anwar
# Write a script to display matrix as below with numbers 1 - 9.
# Please make sure numbers are used once.
#
# [ a b c ]
# [ d e f ]
# [ g h i ]
# So that it satisfies the following:
#
# a + b + c = 15
# d + e + f = 15
# g + h + i = 15
# a + d + g = 15
# b + e + h = 15
# c + f + i = 15
# a + e + i = 15
# c + e + g = 15

# Solution based on Edouard Lucas (https://en.wikipedia.org/wiki/Magic_square#A_method_for_constructing_a_magic_square_of_order_3)
#
# Solution is:
#
# [   c - b     | c + (a + b) |   c - a     ]
# [ c - (a - b) |      c      | c + (a - b) ]
# [   c + a     | c - (a + b) |   c + b     ]
#
# The magic constant is 3c, where  0 < a < b < (c - a)  and  b != 2a.
# Moreover, every 3x3 magic square of distinct positive integers is of this form.
#
# In the problem statement it is said that the sum of each row, column and
# diagonal is 15, this is the square magic constant, therefore we know that:
#
#       c = 5
#
# We need to find the pairs (a,b) that satisfy the above conditions.

# find a and b for a given c
def find_ab(c):
    for a in range(1, 3*c-1+1):
        for b in range(a+1, 3*c+1):
            if b < c-a and b != 2*a:
                return a, b

def square(a, b, c):
    return [[ c - b,       c - (a - b), c + a       ],
            [ c + (a + b), c,           c - (a + b) ],
            [ c - a,       c + (a - b), c + b       ]]

magic_constant = 15
c = int(magic_constant/3)
a, b = find_ab(c)
sq = square(a,b,c)
for row in (sq):
    print("[ "+ " ".join([str(x) for x in row]) +" ]")
