#!/usr/bin/perl
use warnings;
use strict;
use experimental 'signatures';

sub factorial ($n) {
    my $f = 1;
    $f *= $_ for 2 .. $n;
    return $f
}

sub permutation2rank ($arr) {
    my $step = factorial(@$arr - 1);
    my %position;
    @position{sort @$arr} = 0 .. $#$arr;

    my $rank = $step * $position{ $arr->[0] };
    $rank += permutation2rank([@$arr[1 .. $#$arr]])
        if @$arr > 1;
    return $rank
}

sub rank2permutation($arr, $index) {
    my @sorted = sort @$arr;
    return _rank2permutation(\@sorted, $index)
}

sub _rank2permutation ($arr, $index) {
    return $arr if 1 == @$arr;

    my $step = factorial(@$arr - 1);
    my $i = int($index / $step);
    my @permutation = (
        $arr->[$i],
        @{ _rank2permutation([@$arr[grep $_ != $i, 0 .. $#$arr]],
                            $index % $step) });
    return \@permutation
}

use Test::More tests => 6;

is permutation2rank([1, 0, 2]), 2, 'permutation2rank';
is_deeply rank2permutation([0, 1, 2], 1), [0, 2, 1], 'rank2permutation';

is_deeply rank2permutation([3, 0, 1, 2], 17), [2, 3, 1, 0], 'r2p example 1';
is_deeply rank2permutation([3, 0, 1, 2], 18), [3, 0, 1, 2], 'r2p example 2';

is_deeply permutation2rank([2, 3, 1, 0]), 17, 'p2r example 1';
is_deeply permutation2rank([3, 0, 1, 2]), 18, 'p2r example 2';
