#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub count_equal_divisible($k, @ints) {
    my %where;
    for my $i (0 .. $#ints) {
        undef $where{ $ints[$i] }{$i};
    }
    my $count = 0;
    for my $int (keys %where) {
        for my $i (keys %{ $where{$int} }) {
            for my $j (keys %{ $where{$int} }) {
                next if $i <= $j;

                ++$count if 0 == ($i * $j) % $k;
            }
        }
    }
    return $count
}

use Test::More tests => 2;

is count_equal_divisible(2 => 3, 1, 2, 2, 2, 1, 3), 4, 'Example 1';
is count_equal_divisible(1 => 1, 2, 3), 0, 'Example 2';
