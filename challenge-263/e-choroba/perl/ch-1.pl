#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub target_index_naive($target, @ints) {
    my @sorted = sort { $a <=> $b } @ints;
    return grep $sorted[$_] == $target, 0 .. $#sorted
}

sub target_index_binsearch($target, @ints) {
    my @sorted = sort { $a <=> $b } @ints;
    my ($left, $right) = (0, $#sorted);
    while ($left < $right - 1) {
        my $middle = int(($left + $right) / 2);
        if ($sorted[$middle] < $target) {
            $left = $middle;
        } else {
            $right = $middle;
        }
    }
    my $i = $sorted[$left] == $target ? $left : $right;
    return unless $sorted[$i] == $target;  # Not found.

    my $from = $i;
    --$from while $sorted[$from] == $target;

    my $to = $i;
    ++$to while $sorted[$to] == $target;

    return $from + 1 .. $to - 1
}


use Test2::V0;
plan 2 * 3 + 1;

for my $target_index (
    *target_index_naive{CODE},
    *target_index_binsearch{CODE}
) {
    is [$target_index->(2, 1, 5, 3, 2, 4, 2)], [1, 2], 'Example 1';
    is [$target_index->(6, 1, 2, 4, 3, 5)], [], 'Example 2';
    is [$target_index->(4, 5, 3, 2, 4, 2, 1)], [4], 'Example 3';
}
srand;
my @large = map int rand 1000, 0 .. 2000;
my $target = 123;
is  [target_index_binsearch($target, @large)],
    [target_index_naive($target, @large)],
    'same';

use Benchmark qw{ cmpthese };
cmpthese(-3, {
    naive     => sub { target_index_naive($target, @large) },
    binsearch => sub { target_index_binsearch($target, @large) },
});

__END__
            Rate     naive binsearch
naive     2021/s        --      -26%
binsearch 2728/s       35%        --
