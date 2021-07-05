#!/usr/bin/env perl6
#
#
#       chaperone-required.raku
# 
#       Sequence without 1-on-1
#         Submitted by: Cheok-Yin Fung
#         Write a script to generate sequence starting at 1. Consider the
#         increasing sequence of integers which contain only 1’s, 2’s and 3’s,
#         and do not have any doublets of 1’s like below. Please accept a
#         positive integer $N and print the $Nth term in the generated sequence.
# 
#         1, 2, 3, 12, 13, 21, 22, 23, 31, 32, 33, 121, 122, 123, 131, …
# 
#         Example
#         Input: $N = 5
#         Output: 13
# 
#         Input: $N = 10
#         Output: 32
# 
#         Input: $N = 60
#         Output: 2223
#
#       method:
#         In Raku we can create an infinite sequence and access that. The raw
#         numbers are first expresed in base 4, then the elements are filtered
#         to only those that do not contain any didgit other than 1,2, or 3 and
#         do not contain the "11" formation. Now we can take this item as a
#         first-class citizen and access it positionally, reifying the
#         `$ele-1`-th element and print it. We can do all of this anonymously,
#         without even instatating a container to hold it.
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN ( Int $ele where $ele > 0 = 60 ) ;

( (1 … ∞).map(*.base(4))
         .grep({! / 0 | 11 /}) )[$ele-1].say ;

