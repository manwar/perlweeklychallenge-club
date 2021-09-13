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
# We treat each line of input as a different case. Each line contains
# a set of integers, separated by non-digits.
#

while (<>) {
    my %numbers;
    $numbers {$_} ++ for /[1-9][0-9]*/g;         # Read in data
    say grep {$numbers {$_} % 2} keys %numbers;  # Print the one occuring
                                                 # an odd number of times
}
