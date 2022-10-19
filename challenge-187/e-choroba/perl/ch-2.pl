#! /usr/bin/perl
use warnings;
use strict;
use feature qw{ say };
use experimental 'signatures';

sub magical_triplets (@n) {
    @n = sort { $b <=> $a } @n;
    for my $index1 (0 .. $#n - 2) {
        for my $index2 ($index1 + 1 .. $#n - 1) {
            for my $index3 ($index2 + 1 .. $#n) {
                next if $n[$index1] + $n[$index2] <= $n[$index3]
                     || $n[$index1] + $n[$index3] <= $n[$index2]
                     || $n[$index2] + $n[$index3] <= $n[$index1];
                return [@n[$index1, $index2, $index3]];
            }
        }
    }
    return []
}

sub magical_triplets_slow (@n) {
    @n = sort { $b <=> $a } @n;
    my @max;
    for my $index1 (0 .. $#n - 2) {
        for my $index2 ($index1 + 1 .. $#n - 1) {
            for my $index3 ($index2 + 1 .. $#n) {
                next if $n[$index1] + $n[$index2] <= $n[$index3]
                     || $n[$index1] + $n[$index3] <= $n[$index2]
                     || $n[$index2] + $n[$index3] <= $n[$index1];
                my $sum = $n[$index1] + $n[$index2] + $n[$index3];
                @max = ($sum, $index1, $index2, $index3)
                    if $sum > ($max[0] // -1);
            }
        }
    }
    # If sum was ever set, it can't be 0, otherwise 0 + 0 > 0.
    return $max[0] ? [@n[@max[ 1 .. 3]]] : []
}


use Test2::V0;
plan 5;

is magical_triplets(1, 2, 3, 2), [3, 2, 2], 'Example 1';
is magical_triplets(1, 3, 2), [], 'Example 2';
is magical_triplets(1, 1, 2, 3), [], 'Example 3';
is magical_triplets(2, 4, 3), [4, 3, 2], 'Example 4';

my @long_list = map int rand 1_000_000, 1 .. 100;
is magical_triplets(@long_list), magical_triplets_slow(@long_list),
    "long list @{magical_triplets(@long_list)}";

use Benchmark qw{ cmpthese };
cmpthese(-3, {
    fast => sub { magical_triplets(@long_list) },
    slow => sub { magical_triplets_slow(@long_list) },
});

__END__
         Rate    slow    fast
slow   41.0/s      --   -100%
fast 205494/s 501180%      --
