#!/usr/bin/env perl

use v5.35;
use Test2::Bundle::More;
use Algorithm::Combinatorics qw/combinations/;

sub minDiff{
    my $ref_ints = shift;
    my @ints = @$ref_ints;
    my @diffs = sort { $a <=> $b }
                map { abs($_->[0] - $_->[1]) } combinations(\@ints, 2);
    return $diffs[0];
}

my  @ints1 = (1, 5, 8, 9);
is(minDiff(\@ints1), 1, "Test 1");

my @ints2 = (9, 4, 1, 7);
is(minDiff(\@ints2), 2, "Test 2");

done_testing();
