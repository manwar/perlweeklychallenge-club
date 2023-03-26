#!/usr/bin/env python
#-------------------------------------------
# AUTHOR: Robert DiCicco
# DATE  : 2023-03-21
# Challenge 209 Special Bit Chars ( Python )
#-------------------------------------------

bits = [[1, 0, 0],[1, 1, 1, 0]]

ln = len(bits)
flag = 0

for mysub in bits:
    print("\nInput: @bits = ",mysub)
    ref_len = len(mysub)
    for x in range(ref_len):
        if mysub[x] == 1:
            if flag == 0  :
                flag = 1
            else:
                print('c ',end='')
                lastchar = 'c'
                flag = 0

        elif mysub[x] == 0:
            if flag == 0:
                print('a ',end='')
                lastchar = 'a'
            elif flag == 1:
                print('b ',end='')
                lastchar = 'b'
                flag = 0
    if lastchar == 'a' and flag == 0:
        print("\nOutput: 1")
    else:
        print("\nOutput: 0")
#-------------------------------------------
# SAMPLE OUTPUT
# python .\SpecialBit.py

# Input: @bits =  [1, 0, 0]
# b a
# Output: 1

# Input: @bits =  [1, 1, 1, 0]
# c b
# Output: 0
#-------------------------------------------
