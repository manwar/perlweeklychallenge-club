### https://theweeklychallenge.org/blog/perl-weekly-challenge-245/
"""

Task 1: Sort Language

Submitted by: [45]Mohammad S Anwar
     __________________________________________________________________

   You are given two array of languages and its popularity.

   Write a script to sort the language based on popularity.

Example 1

Input: @lang = ('perl', 'c', 'python')
       @popularity = (2, 1, 3)
Output: ('c', 'perl', 'python')

Example 2

Input: @lang = ('c++', 'haskell', 'java')
       @popularity = (1, 3, 2)
Output: ('c++', 'java', 'haskell')

Task 2: Largest of Three
"""
### solution by pokgopun@gmail.com

def sortL(tup1,tup2: tuple):
    return tuple(
            tup[0] for tup in
            sorted(
                map(lambda e1,e2: (e1,e2), tup1, tup2),
                key=lambda tup: tup[1]
                )
            )

for (inpt1,inpt2), otpt in {
        (('perl', 'c', 'python'), (2, 1, 3)): ('c', 'perl', 'python'),
        (('c++', 'haskell', 'java'), (1, 3, 2)): ('c++', 'java', 'haskell'),
        }.items():
    print(otpt==sortL(inpt1, inpt2))
