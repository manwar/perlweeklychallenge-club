#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

use List::Util qw [max];

#
# See ../README.md
#

#
# Run as: perl ch-1.pl < input-file
#

while (<>) {
    #
    # Read numbers, and sort them.
    #
    my @N = sort {$a <=> $b} split;

    #
    # Find the maximum of successive elements, and print them.
    # Note that the array is sorted, so $N [$_] - $N [$_ - 1]
    # is always a non-negative number -- no need to take the
    # absolute value.
    #
    # If we have just one number, $#N will be 0, so the map
    # returns an empty list. In that case, max returns undef.
    # Hence the // 0.
    #
    say max (map {$N [$_] - $N [$_ - 1]} 1 .. $#N) // 0;
}
