### https://theweeklychallenge.org/blog/perl-weekly-challenge-244/
"""

Task 2: Group Hero

Submitted by: [46]Mohammad S Anwar
     __________________________________________________________________

   You are given an array of integers representing the strength.

   Write a script to return the sum of the powers of all possible
   combinations; power is defined as the square of the largest number in a
   sequence, multiplied by the smallest.

Example 1

Input: @nums = (2, 1, 4)
Output: 141

Group 1: (2) => square(max(2)) * min(2) => 4 * 2 => 8
Group 2: (1) => square(max(1)) * min(1) => 1 * 1 => 1
Group 3: (4) => square(max(4)) * min(4) => 16 * 4 => 64
Group 4: (2,1) => square(max(2,1)) * min(2,1) => 4 * 1 => 4
Group 5: (2,4) => square(max(2,4)) * min(2,4) => 16 * 2 => 32
Group 6: (1,4) => square(max(1,4)) * min(1,4) => 16 * 1 => 16
Group 7: (2,1,4) => square(max(2,1,4)) * min(2,1,4) => 16 * 1 => 16

Sum: 8 + 1 + 64 + 4 + 32 + 16 + 16 => 141
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 26th November
   2023.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

from itertools import combinations

def sumOfPower(tup: tuple):
    return sum(
            sum(
                max(x)**2 * min(x) for x in combinations(tup,n)
                ) for n in range(1,len(tup)+1)
            )

for inpt,otpt in {
        (2, 1, 4): 141,
        }.items():
    print(otpt==sumOfPower(inpt))



