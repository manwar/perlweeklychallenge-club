#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-140/#TASK2
#

#
# Run as: perl ch-2.pl < input-file
#

#
# We consider all numbers, starting from 1. For each number $n, we will
# count how many times it occurs in the multiplication table. This
# is exactly the numbers of divisor $d, such that $d <= $i and $n / $d <= $j.
# Then it's just a matter of bookkeepping till we have found the right
# solution.
#
# Math::Prime::Util has a utility function, fordivisors, which iterates
# over the divisors of a given number.
#
# We also have two different solutions:
#
# A naive one, which calculates all numbers p = n * m, 1 <= n <= i, 1 <= m <= j,
# sorts the list, then selects the nth element. This is on ch-2b.pl.
#
# One which goes through the multiplication table in order, avoiding
# finding divisors of numbers. This is in ch-2a.pl.
#

use Math::Prime::Util qw [fordivisors];

MAIN: while (<>) {
    my ($n, $i, $j, $k) = (0, split);
    fordivisors {$_ <= $i && $n / $_ <= $j && !-- $k && say $n} ++ $n
           while $k >= 1;
}
