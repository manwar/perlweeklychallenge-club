#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-150
#

#
# Run as: perl ch-2.pl
#

#
# This is sequence A005117 in the OEIS.
#
# I guess we could factorize each number and check for duplicate factors,
# and that might be the way to go if we wanted to determine whether a
# a really large number is square free.
#
# Or we could use a sieve -- again, useful when dealing with (a range of)
# large numbers.
#
# But we only need to determine square free numbers up to 500. Which
# means we only need to test whether such numbers aren't divisible by
# p^2, for prime p, such that p^2 < 500.
#
# 361 = 19^2 < 500 < 23^2 = 529
#
# So, we only need to check whether they aren't divisible by 8 numbers.
# (We could stop checking as soon as we find a square which divides the
#  number, but then we would not have a one-liner...)
#
#
# Of course, since this is just yet another "get the first N values
# from a sequence listed at the OEIS", we could just print out the
# expected numbers, and turn this into a glorified Hello, World program.
#

$, = " ";
say grep {$a = $_; 8 == grep {$a % $_ ** 2} 2, 3, 5, 7, 11, 13, 17, 19} 1 .. 500
