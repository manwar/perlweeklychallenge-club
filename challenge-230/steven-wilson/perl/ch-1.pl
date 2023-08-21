#!/usr/bin/env perl

use 5.12.0;
use Test2::V0 -no_srand;

is( seperate_digits( ( 1, 34, 5, 6 ) ),
    array {
        item 1;
        item 3;
        item 4;
        item 5;
        item 6
    },
    "Example 1"
);
is( seperate_digits( ( 1, 24, 51, 60 ) ),
    array {
        item 1;
        item 2;
        item 4;
        item 5;
        item 1;
        item 6;
        item 0
    },
    "Example 2"
);
done_testing();

sub seperate_digits {
    my @elements        = @_;
    my @seperate_digits = map { split // } @elements;
    return \@seperate_digits;
}
