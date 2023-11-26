### https://theweeklychallenge.org/blog/perl-weekly-challenge-238/
"""

Task 2: Persistence Sort

Submitted by: [44]Mohammad S Anwar
     __________________________________________________________________

   You are given an array of positive integers.

   Write a script to sort the given array in increasing order with respect
   to the count of steps required to obtain a single-digit number by
   multiplying its digits recursively for each array element. If any two
   numbers have the same count of steps, then print the smaller number
   first.

Example 1

Input: @int = (15, 99, 1, 34)
Output: (1, 15, 34, 99)

15 => 1 x 5 => 5 (1 step)
99 => 9 x 9 => 81 => 8 x 1 => 8 (2 steps)
1  => 0 step
34 => 3 x 4 => 12 => 1 x 2 => 2 (2 steps)

Example 2

Input: @int = (50, 25, 33, 22)
Output: (22, 33, 50, 25)

50 => 5 x 0 => 0 (1 step)
25 => 2 x 5 => 10 => 1 x 0 => 0 (2 steps)
33 => 3 x 3 => 9 (1 step)
22 => 2 x 2 => 4 (1 step)
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 15th October
   2023.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

def mk1dgt(num):
    i = 0
    while num > 9:
        i += 1
        num = eval(
                "*".join(
                    map(
                        lambda x: chr(x), bytes(str(num),"ascii")
                        )
                    )
                )
    return i

def pSort(tup):
    lst = sorted(list(tup))
    lst.sort(key=mk1dgt)
    return tuple(lst)

for inpt, otpt in {
        (15, 99, 1, 34):(1, 15, 34, 99),
        (50, 25, 33, 22):(22, 33, 50, 25),
        }.items():
    print(pSort(inpt)==otpt)


