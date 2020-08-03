#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.32);
use experimental qw(signatures);
use Lingua::EN::Inflect qw(PL);

# TASK #1 › Trailing Zeroes
# Submitted by: Mohammad S Anwar
#
# You are given a positive integer $N (<= 10).
#
# Write a script to print number of trailing zeroes in $N!.
# Example 1
# Input: $N = 10
# Output: 2 as $N! = 3628800 has 2 trailing zeroes
#
# Example 2
# Input: $N = 7
# Output: 1 as $N! = 5040 has 1 trailing zero
#
# Example 3
# Input: $N = 4
# Output: 0 as $N! = 24 has 0 trailing zero

sub fact($n) {
    my $res = 1;
    $res *= $_ for 2..$n;
    return $res;
}

sub num_trailing_zeros($n) {
    my $cnt = 0;
    my $pwr = 10;
    while ($n % $pwr == 0) {
        $cnt++;
        $pwr *= 10;
    }
    return $cnt;
}

my $n = shift @ARGV;
my $f = fact($n);
my $z = num_trailing_zeros($f);
say "$n as \$N! = $f has $z trailing ", PL("zero", $z);

