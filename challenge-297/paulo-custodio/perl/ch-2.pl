#!/usr/bin/env perl

use Modern::Perl;
use List::Util qw(min max);

@ARGV or die "usage: $0 nums...\n";
say num_swaps(@ARGV);

sub num_swaps {
    my(@nums) = @_;
    my $min = min(@nums);
    my $min_idx = (map {$_->[0]} grep {$_->[1]==$min} map {[$_, $nums[$_]]} 0..$#nums)[0];

    # must move the minimum to the front, because it may impact the maximum position
    for my $i (reverse 0 .. $min_idx-1) {
        ($nums[$i+1], $nums[$i]) = ($nums[$i], $nums[$i+1]);
    }

    # no need to reorder the array
    my $max = max(@nums);
    my $max_idx = (map {$_->[0]} grep {$_->[1]==$max} map {[$_, $nums[$_]]} reverse 0..$#nums)[0];
    return $min_idx + ($#nums-$max_idx);
}
