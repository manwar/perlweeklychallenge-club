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
# Run as: perl ch-2b.pl < input-file
#

#
# Trivial solution. Will easily out of memory.
#
# We'll calculate all number n * m, 1 <= n <= i, 1 <= m <= j, sort them,
# and then take the kth element.
#

while (<>) {
    my ($i, $j, $k) = split;
    say +(sort {$a <=> $b} map {my $l = $_; map {$_ * $l} 1 .. $j} 1 .. $i)
         [$k - 1];
}

