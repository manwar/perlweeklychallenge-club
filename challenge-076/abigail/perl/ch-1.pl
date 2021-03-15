#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

use Math::Prime::Util qw [is_prime];

#
# The Goldbach conjecture says that every even number greater than 2
# is the sum of two primes. This has been verified for numbers up to
# 4 * 10^18. We will assume it's always true.
#
# This means the answer is:
#
#   No answer, if the number is less than 2;
#   1, if the number is prime;
#   2, if the number is even, or 2 more than a prime number;
#   3, otherwise.
#

while (<>) {
    chomp;
    say  $_ < 2                            ? "No answer possible"
      :                  is_prime ($_)     ? 1
      : ($_ % 2 == 0) || is_prime ($_ - 2) ? 2
      :                                      3;
}
