#!/usr/bin/env perl

use v5.35;
use Test2::Bundle::More;

sub checkOrder {
    my @ints = @_;
    my @sorted_ints = sort { $a <=> $b } @ints;
    return grep {  $ints[$_] != $sorted_ints[$_]  } 0..scalar @ints - 1;
}

is_deeply([checkOrder(5, 2, 4, 3, 1)], [0, 2, 3, 4], "Test 1" );
is_deeply([checkOrder(1, 2, 1, 1, 3)], [1, 3], "Test 2" );
is_deeply([checkOrder(3, 1, 3, 2, 3)], [0, 1, 3], "Test 3" );
done_testing();
