#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.32);
use experimental qw(signatures);

# You are given a positive number $N.

# Write a script to count the total numbrer of set bits of the binary
# representations of all numbers from 1 to $N and return
# $total_count_set_bit % 1000000007.

sub bits_set($x) {
    my $bin = sprintf "%b", $x;
    return $bin =~ tr/1//;
}

my $MOD = 1000000007;
my $n = $ARGV[0];
my $sum = 0;
$sum += bits_set($_) for 1..$n;

say $sum, " ", $sum % $MOD;
