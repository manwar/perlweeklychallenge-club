#
# Challenge:
#
#   You are given a positive number $N.
#
#   Write a script to count the total numbrer of set bits of the binary
#   representations of all numbers from 1 to $N and return
#   $total_count_set_bit % 1000000007.
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-079/
#

#
# This is A000778 (https://oeis.org/A000788). There's a recursive formala
# for the number of bits in the binary representation of 0 .. $N:
#
#    bits (0) = 0
#    bits (2 * N)     =     bits (N) + bits (N - 1) + N
#    bits (2 * N + 1) = 2 * bits (N)                + N + 1
#

function f(nn, n) {
    if (nn == 0) {return (0);}
    if (nn % 2 == 1) {
        n = (nn - 1) / 2;
        return 2 * f(n) + n + 1;
    }
    n = nn / 2;
    return f(n) + f(n - 1) + n;
}

BEGIN   {bignum = 1000000007;}
        {print f($1) % bignum;}
