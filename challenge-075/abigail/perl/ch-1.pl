#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# See ../README.md
#

#
# Run as: perl ch-1.pl < input-file
#

use List::Util qw [sum];


sub possibilities ($target, @coins) {
    return $target == 0            ? 1
         : $target <  0 || !@coins ? 0
         : sum map {possibilities ($target - $_ * $coins [0],
                                    @coins [1 .. $#coins])}
                0 .. int ($target / $coins [0]);
}

say possibilities /[0-9]+/g while <>;
