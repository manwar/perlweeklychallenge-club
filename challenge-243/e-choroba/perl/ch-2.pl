#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use POSIX qw{ floor };

sub floor_sum(@nums) {
    my $sum = 0;
    for my $i (@nums) {
        for my $j (@nums) {
            $sum += floor($i / $j);
        }
    }
    return $sum
}

use List::Util qw{ sum };
sub floor_sum_functional(@nums) {
    sum(map { my $i = $_; map floor($i / $_), @nums } @nums)
}
# Benchmark shows no significant difference in performance.

use Test::More tests => 2 + 2;

is floor_sum(2, 5, 9), 10, 'Example 1';
is floor_sum(7, 7, 7, 7, 7, 7, 7), 49, 'Example 2';

is floor_sum_functional(2, 5, 9), 10, 'Example 1 func';
is floor_sum_functional(7, 7, 7, 7, 7, 7, 7), 49, 'Example 2 func';
