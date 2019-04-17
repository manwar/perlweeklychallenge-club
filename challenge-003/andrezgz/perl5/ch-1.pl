#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-003/
# Challenge #1
# Create a script to generate 5-smooth numbers, whose prime divisors are less or equal to 5.
# They are also called Hamming/Regular/Ugly numbers.
# For more information, please check this wikipedia. https://en.wikipedia.org/wiki/Regular_number

use strict;

my $last = shift || 20;

foreach my $n ( 1 .. $last ) {
    my $r = $n;
    for (2,3,5) { $r /= $_ until ($r % $_) }
    print $n.$/ if ($r == 1);
}
