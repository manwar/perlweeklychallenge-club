#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::Util qw{ sum0 };

sub left_right_sum_diff(@ints) {
    my $l = 0;
    my $r = sum0(@ints[1 .. $#ints]);
    my @diff;
    for my $i (0 .. $#ints) {
        push @diff, abs($l - $r);
        $l += $ints[$i];
        $r -= $i < $#ints ? $ints[$i + 1] : 0;
    }
    return \@diff
}

sub left_right_sum_diff_naive(@ints) {
    my @left = my $s = 0;
    push @left, map $s += $_, @ints[0 .. $#ints - 1];

    $s = 0;
    my @right = reverse 0, map $s += $_, reverse @ints[1 .. $#ints];

    return [map abs($left[$_] - $right[$_]), 0 .. $#left]
}

use Test2::V0;
plan 2 * 3;

for my $f (*left_right_sum_diff_naive{CODE}, *left_right_sum_diff{CODE}) {
    is $f->(10, 4, 8, 3), [15, 1, 11, 22], 'Example 1';
    is $f->(1), [0], 'Example 2';
    is $f->(1, 2, 3, 4, 5), [14, 11, 6, 1, 10], 'Example 3';
}

use Benchmark qw{ cmpthese };
my @in = 1 .. 15;
cmpthese(-3, {
    naive => sub { left_right_sum_diff_naive(@in) },
    optimized => sub { left_right_sum_diff(@in) },
});

__END__
              Rate     naive optimized
naive     133552/s        --      -20%
optimized 167637/s       26%        --
