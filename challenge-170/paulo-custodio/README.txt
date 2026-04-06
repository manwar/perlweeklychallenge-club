Perl Weekly Challenge 170
https://theweeklychallenge.org/blog/perl-weekly-challenge-170/

Task 1: Primorial Numbers
Submitted by: Mohammad S Anwar
Write a script to generate first 10 Primorial Numbers.


Primorial numbers are those formed by multiplying successive prime numbers.


For example,

P(0) = 1    (1)
P(1) = 2    (1x2)
P(2) = 6    (1x2x3)
P(3) = 30   (1x2x3x5)
P(4) = 210  (1x2x3x5x7)


Task 2: Kronecker Product
Submitted by: Mohammad S Anwar
You are given 2 matrices.

Write a script to implement Kronecker Product on the given 2 matrices.

For more information, please refer wikipedia page.


For example,

A = [ 1 2 ]
    [ 3 4 ]

B = [ 5 6 ]
    [ 7 8 ]

A x B = [ 1 x [ 5 6 ]   2 x [ 5 6 ] ]
        [     [ 7 8 ]       [ 7 8 ] ]
        [ 3 x [ 5 6 ]   4 x [ 5 6 ] ]
        [     [ 7 8 ]       [ 7 8 ] ]

      = [ 1x5 1x6 2x5 2x6 ]
        [ 1x7 1x8 2x7 2x8 ]
        [ 3x5 3x6 4x5 4x6 ]
        [ 3x7 3x8 4x7 4x8 ]

      = [  5  6 10 12 ]
        [  7  8 14 16 ]
        [ 15 18 20 24 ]
        [ 21 24 28 32 ]
