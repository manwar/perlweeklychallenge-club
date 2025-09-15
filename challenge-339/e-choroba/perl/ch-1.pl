#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use constant RANDOM_TESTS => 50;

sub max_diff_nested_loops(@ints) {
    my $max_diff = 0;
    for my $i (0 .. $#ints) {
        for my $j (0 .. $#ints) {
            next if $i == $j;

            for my $k (0 .. $#ints) {
                next if $i == $k || $j == $k;

                for my $l (0 .. $#ints) {
                    next if $i == $l || $j == $l || $k == $l;

                    my $diff = $ints[$i] * $ints[$j] - $ints[$k] * $ints[$l];
                    $max_diff = $diff if $diff > $max_diff;
                }
            }
        }
    }
    return $max_diff
}

sub max_diff(@ints) {
    @ints = sort { $a <=> $b } @ints;
    return max_diff_nested_loops(@ints) if @ints <= 8;
    return max_diff_nested_loops(@ints[0 .. 3, $#ints - 3 .. $#ints])
}

use Test::More tests => (5 + 1) * 2 + RANDOM_TESTS + 1;

for my $max_diff (\&max_diff_nested_loops, \&max_diff) {
    is $max_diff->(5, 9, 3, 4, 6), 42, 'Example 1';
    is $max_diff->(1, -2, 3, -4), 10, 'Example 2';
    is $max_diff->(-3, -1, -2, -4), 10, 'Example 3';
    is $max_diff->(10, 2, 0, 5, 1), 50, 'Example 4';
    is $max_diff->(7, 8, 9, 10, 10), 44, 'Example 5';
    is $max_diff->(20, 17, -6, -8, -8, -3, -9, -1), 337, '6 not enough';
}

for (1 .. RANDOM_TESTS) {
    my $size = 4 + int rand 10;
    my @ints = map int(rand 50) - 25, 1 .. $size;
    is max_diff(@ints), max_diff_nested_loops(@ints), "same @ints";

}

use Benchmark qw{ cmpthese };

my @ints = map int(rand 50) - 25, 1 .. 25;
is max_diff(@ints), max_diff_nested_loops(@ints), "same @ints";

cmpthese(-3, {
    nested    => sub { max_diff_nested_loops(@ints) },
    optimised => sub { max_diff(@ints) },
});
