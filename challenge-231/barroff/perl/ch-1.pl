#!/usr/bin/env perl

use v5.38;

sub min_max (@ints) {
    return -1 if @ints < 3;
    my @sorted_ints = sort @ints;
    my @result      = @sorted_ints[ 1 .. @sorted_ints - 2 ];
    return \@result;
}

sub MAIN() {
    if (@ARGV) {

        #| Run command line arguments
        say min_max(@ARGV);
    }
    else {
        #| Run test cases
        use Test2::V0 qw( is plan );
        plan 3;

        is min_max( ( 3, 2, 1, 4 ) ), [ 2, 3 ], 'works for (3, 2, 1, 4)';
        is min_max( ( 3, 1 ) ),       -1,       'works for (3, 1)';
        is min_max( ( 2, 1, 3 ) ),    [2],      'works for (2, 1, 3)';
    }
}

MAIN();
