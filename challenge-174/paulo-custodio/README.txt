Perl Weekly Challenge 174
https://theweeklychallenge.org/blog/perl-weekly-challenge-174/

Task 1: Disarium Numbers
Submitted by: Mohammad S Anwar
Write a script to generate first 19 Disarium Numbers.


A disarium number is an integer where the sum of each digit raised to the power of its position in the number, is equal to the number.


For example,

518 is a disarium number as (5 ** 1) + (1 ** 2) + (8 ** 3) => 5 + 1 + 512 => 518


Task 2: Permutation Ranking
Submitted by: Mohammad S Anwar
You are given a list of integers with no duplicates, e.g. [0, 1, 2].

Write two functions, permutation2rank() which will take the list and determine its rank (starting at 0) in the set of possible permutations arranged in lexicographic order, and rank2permutation() which will take the list and a rank number and produce just that permutation.

Please checkout this post for more informations and algorithm.

Given the list [0, 1, 2] the ordered permutations are:

0: [0, 1, 2]
1: [0, 2, 1]
2: [1, 0, 2]
3: [1, 2, 0]
4: [2, 0, 1]
5: [2, 1, 0]

and therefore:

permutation2rank([1, 0, 2]) = 2

rank2permutation([0, 1, 2], 1) = [0, 2, 1]
