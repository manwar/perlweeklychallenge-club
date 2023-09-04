# https://theweeklychallenge.org/blog/perl-weekly-challenge-233/
"""
Task 2: Frequency Sort

Submitted by: [44]Mohammad S Anwar
     __________________________________________________________________

   You are given an array of integers.

   Write a script to sort the given array in increasing order based on the
   frequency of the values. If multiple values have the same frequency
   then sort them in decreasing order.

Example 1

Input: @ints = (1,1,2,2,2,3)
Ouput: (3,1,1,2,2,2)

'3' has a frequency of 1
'1' has a frequency of 2
'2' has a frequency of 3

Example 2

Input: @ints = (2,3,1,3,2)
Ouput: (1,3,3,2,2)

'2' and '3' both have a frequency of 2, so they are sorted in decreasing order.

Example 3

Input: @ints = (-1,1,-6,4,5,-6,1,4,1)
Ouput: (5,-1,4,4,-6,-6,1,1,1)
"""
def mTup(tup):
    dct = {} ### key = number, value = frequency
    for i in tup:
        if dct.get(i):
            dct[i] += 1
        else:
            dct[i] = 1
    #print(dct)
    rdct = {} ### reverse of dct, key = frequency, value = list of number with the frequency
    for k,v in dct.items():
        if rdct.get(v):
            rdct[v].append(k)
        else:
            rdct[v] = [k]
    #print(rdct)
    lst = []
    ### sort key (frequency) so number will be added to list in increasing order
    for k in sorted(rdct.keys()):
        ### sort value (numbers) so number with same frequency will be add to list in decreasing order
        for v in sorted(rdct[k],reverse=True):
            for i in range(k):
                lst.append(v)
    return tuple(lst)
        
for src, dst in {
    (1,1,2,2,2,3): (3,1,1,2,2,2),
    (2,3,1,3,2): (1,3,3,2,2),
    (-1,1,-6,4,5,-6,1,4,1): (5,-1,4,4,-6,-6,1,1,1),
}.items():
    print(mTup(src)==dst)
