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
# Run as: perl ch-2.pl < input-file
#

my @DIGITS = (0 .. 9);
my @EVENS  = grep {$_ % 2 == 0} @DIGITS;

while (<>) {
    #
    # Read in data, store counts of each digit.
    #
    my @digits = (0) x @DIGITS;
    $digits [$_] ++ for do {local $" = ""; /[@DIGITS]/g};

    #
    # The last number of the output should be the smallest
    # even number in the input. If there is no even number
    # in the input, skip it.
    #
    my ($last) = grep {$digits [$_]} @EVENS;
    next unless defined $last;
    $digits [$last] --;

    #
    # Print the result, with the highest numbers first.
    #
    print join "" => map {$_ x $digits [$_]} reverse @DIGITS;
    say $last;
}
