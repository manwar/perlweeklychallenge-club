#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-147
#

#
# Run as: perl ch-2.pl
#

#
# We solve this by checking every pentagon number in order to see
# whether it can be written as a sum of two (smaller) pentagon
# numbers. If so, if their difference is a pentagon number, we
# have the winning pair. We'll use a hash which tracks the pentagon
# numbers seen so far.
#
# To calculate the next pentagon number, we will avoid division
# (and multiplication).
#
# If P (N) == N * (3 * N - 1) / 2, then
#
# P (N + 1) == (N + 1) * (3 * (N + 1) - 1) / 2
#           == ((N + 1) * (3 * N + 2) / 2
#           == (3 * N * N + 5 * N + 2) / 2
#           == (3 * N * N - N + 6 * N + 2) / 2
#           == (N * (3 * N - 1) / 2) + ((6 * N + 2) / 2)
#           == P (N) + 3 * N + 1
#           == P (N) + N + N + N + 1
#

my %pentagon;

MAIN: for (;;) {
    state $n = 0;
    state $p = 0;
    $pentagon {$p += $n + $n + $n ++ + 1} ++;

    $_ + $_ < $p && $pentagon  {$p - $_}
                 && $pentagon  {$p - $_ - $_}
                 && say ("$_ ", $p - $_)
                 && last MAIN for keys %pentagon;
}

