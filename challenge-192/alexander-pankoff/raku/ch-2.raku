#!/usr/bin/env raku

use Test;

is( equal-distribution(Array[Int].new: <1 0 5>),  4, "Example 1" );
is( equal-distribution(Array[Int].new: <0 2 0>), -1, "Example 2" );
is( equal-distribution(Array[Int].new: <0 3 0>),  2, "Example 3" );
is( equal-distribution(Array[Int].new),           0, "Example (empty list)" );
is( equal-distribution(Array[Int].new: <1>),      0, "Example (singleton list)" );

sub equal-distribution(Int @list --> Int) {
    if (@list.elems <= 1 ) {
        return 0;
    } 

    my $total = @list.sum;

    if ($total % @list.elems != 0) {
        return -1;
    }

    my $target = $total div @list.elems;
    return (0, |@list).produce({$^a + $^b - $target}).map(&abs).sum;
}