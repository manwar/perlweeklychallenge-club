#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

my @fib = (1, 2);  # 1,1 can never appear, anyway.
sub zeckendorf_representation($int) {
    while ($fib[-1] < $int) {
        push @fib, $fib[-1] + $fib[-2];
    }
    return @fib[ _zr($int) ]
}

sub _zr($int) {
    my $last = $#fib + 1;
    my @rep;
    for my $i (reverse 0 .. $#fib) {
        next if $i + 1 == $last;

        if ($int - $fib[$i] >= 0) {
            push @rep, $last = $i;
            $int -= $fib[$i];
        }
    }
    return @rep
}

use Test2::V0;
plan(5);

is [zeckendorf_representation(4)], [3, 1], 'Example 1';
is [zeckendorf_representation(12)], [8, 3, 1], 'Example 2';
is [zeckendorf_representation(20)], [13, 5, 2], 'Example 3';
is [zeckendorf_representation(96)], [89, 5, 2], 'Example 4';
is [zeckendorf_representation(100)], [89, 8, 3], 'Example 5';
