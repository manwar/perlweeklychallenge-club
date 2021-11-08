#!/usr/bin/perl

# https://theweeklychallenge.org/blog/perl-weekly-challenge-134/
# TASK #1
#
# Write a script to generate first 5 Pandigital Numbers in base 10.
#
# As per the wikipedia (https://en.wikipedia.org/wiki/Pandigital_number), it says:
#
# A pandigital number is an integer that in a given base has among its significant digits each digit used in the base at least once.

use strict;
use warnings;
use feature 'say';

# start from the first obvious pandigital number in base 10
my $n = 1023456789;

my @pandigitals;
while (@pandigitals < 5) {
    my %unique;
    $unique{$_}++ for split //, $n;
    push @pandigitals, $n if '1' x 10 eq join '', values %unique;
    $n++;
}

say join "\n", @pandigitals;
exit 0;

__END__

$ ./ch-1.pl
1023456789
1023456798
1023456879
1023456897
1023456978
