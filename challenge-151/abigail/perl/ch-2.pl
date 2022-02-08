#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-151
#

#
# Run as: perl ch-2.pl < input-file
#

use List::Util qw [max];

#
# We'll calculate the best way to rob the houses by working backwards.
# For each house, there are two options: rob the house, or skip it.
# The maximum value we get for robbing the house is the sum of
# the value of the current house, plus the maximum we can get
# if we started two houses down. The maximum value we can get by
# not robbing this house is the best we can get by starting from
# the next house. We'll add two empty houses to make everything work
# out nicely.
#
# Note that we don't have to calculate the best option starting
# from the second house, as we will always skip the second house.
# And we must always pick the first house.
#

sub best ($houses) {
    my @best;
    $best [$#$houses + 1] = 0;
    $best [$#$houses + 2] = 0;
    for (my $i = $#$houses; $i >= 2; $i --) {
        $best [$i] = max $$houses [$i] + $best [$i + 2], $best [$i + 1];
    }
    $$houses [0] + $best [2];
}


say best [/[0-9]+/g] while <>;
