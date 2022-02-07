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
# the next house.
#
# We need some fiddling around the edges:
#    - Maximizing the value starting from the last house is by robbing it.
#    - Maximizing the value starting from the penultimate house is
#      robbing the most valuable of the last two houses.
#    - If there are only two houses, rob the current house.
#    - The first house should always be robbed (a requirement); the
#      maximum value which can be achieved we get by starting from the
#      third house, adding the value of the first.
#

sub best ($houses) {
    my @best;
    foreach my $i (reverse keys @$houses) {
        $best [$i] = @$houses < 2        ?     $$houses [$i]
                   : $i == $#$houses     ?     $$houses [$i]
                   : $i == 0             ?     $$houses [$i] + $best [$i + 2]
                   : $i == $#$houses - 1 ? max $$houses [$i],  $best [$i + 1]
                   :                       max $$houses [$i] + $best [$i + 2],
                                                               $best [$i + 1];
    }
    $best [0];
}


say best [/[0-9]+/g] while <>;
