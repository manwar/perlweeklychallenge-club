#!/usr/bin/python3

# Challenge 080
#
# TASK #2 > Count Candies
# Submitted by: Mohammad S Anwar
# You are given rankings of @N candidates.
#
# Write a script to find out the total candies needed for all candidates.
# You are asked to follow the rules below:
#
# a) You must given at least one candy to each candidate.
# b) Candidate with higher ranking get more candies than their mmediate
# neighbors on either side.
# Example 1:
# Input: @N = (1, 2, 2)
# Explanation:
# Applying rule #a, each candidate will get one candy. So total candies needed
# so far 3. Now applying rule #b, the first candidate do not get any more candy
# as its rank is lower than it's neighbours. The second candidate gets one more
# candy as it's ranking is higher than it's neighbour. Finally the third
# candidate do not get any extra candy as it's ranking is not higher than
# neighbour. Therefore total candies required is 4.
#
# Output: 4
# Example 2:
# Input: @N = (1, 4, 3, 2)
# Explanation:
# Applying rule #a, each candidate will get one candy. So total candies needed
# so far 4. Now applying rule #b, the first candidate do not get any more candy
# as its rank is lower than it's neighbours. The second candidate gets two more
# candies as it's ranking is higher than it's both neighbour. The third
# candidate gets one more candy as it's ranking is higher than it's neighbour.
# Finally the fourth candidate do not get any extra candy as it's ranking is
# not higher than neighbour. Therefore total candies required is 7.
#
# Output: 7

import sys

def candies(n):
    candy = [1 for x in n]
    for i in range(len(n)):
        if i>0:
            if n[i]>n[i-1]:
                candy[i] += 1
        if i<len(n)-1:
            if n[i]>n[i+1]:
                candy[i] += 1
    return candy

print(sum(candies([int(x) for x in sys.argv[1:]])))
