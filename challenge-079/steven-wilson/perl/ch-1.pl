#!/usr/bin/env perl
# TASK #1 › Count Set Bits
# Submitted by: Mohammad S Anwar
# 
# You are given a positive number $N.
# 
# Write a script to count the total numbrer of set bits of the binary
# representations of all numbers from 1 to $N and return
# $total_count_set_bit % 1000000007.

use strict;
use warnings;
use List::Util qw/ sum /;
use feature qw/ say /;

my $num = $ARGV[0];
my $cat_binary_strings;

die "Number was not positive" if $num < 1;

for (1 .. $num) {
    $cat_binary_strings .= sprintf("%b", $_);
}

my $total_set_bit_count = sum( split //, $cat_binary_strings );

say $total_set_bit_count % 1000000007;

