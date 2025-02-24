#!/usr/bin/env perl

use v5.35;
use Test2::Bundle::More;

sub minGap{
    my $ref_ints = shift;
    my @ints = @$ref_ints;

    my @gaps = sort {  $a->[0] <=> $b->[0] || $a->[1] <=> $b->[1]  }
               map { [$ints[$_ + 1] - $ints[$_], $ints[$_+ 1]]  } (0..scalar @ints - 2);
    return $gaps[0][1];
}

my  @ints1 = (2, 8, 10, 11, 15);
is(minGap(\@ints1), 11, "Test 1");

my @ints2 = (1, 5, 6, 7, 14);
is(minGap(\@ints2), 6, "Test 2");

my @ints3 = (8, 20, 25, 28);
is (minGap(\@ints3), 28, "Test 3");

done_testing();
