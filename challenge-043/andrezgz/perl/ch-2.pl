#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-043/
# Task #2
# Self-descriptive Numbers
# Contributed by Laurent Rosenfeld
# Write a script to generate Self-descriptive Numbers in a given base.
# In mathematics, a self-descriptive number is an integer m that
# in a given base b is b digits long in which each digit d at position n
# (the most significant digit being at position 0 and the least significant
# at position b - 1) counts how many instances of digit n are in m.
#
# For example, if the given base is 10, then script should print 6210001000.
# For more information, please checkout wiki page.
# https://en.wikipedia.org/wiki/Self-descriptive_number

use strict;
use warnings;

my $base = shift || 10;
die "No self-descriptive numbers in base $base" if ($base <4 || $base == 6);

if ($base >= 7) {
    my @symbols = (0..9,'A'..'Z');
    print $symbols[$base - 4] . '21' . '0' x ($base - 7) . '1000' . $/;
}
else{
    my $from = '1' . '0' x ($base-1);
    my $to = '9' x $base;

    for my $n ($from .. $to) {
        my @count = (0) x $base;
        $count[$_]++ for split //, $n;
        print $n.$/ if ($n eq join '',@count[0..$base-1]);
    }
}

__END__

./ch-2.pl 4
1210
2020

./ch-2.pl 6
No self-descriptive numbers in base 6

./ch-2.pl 10
6210001000

./ch-2.pl 16
C210000000001000
