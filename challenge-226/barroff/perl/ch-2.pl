#!/usr/bin/env perl

use v5.38;

sub zero_array (@ints) {
    use List::Util qw( uniq );
    scalar grep { $_ > 0 } uniq @ints;
}

sub MAIN() {
    if (@ARGV) {

        #| Run command line arguments
        say zero_array(@ARGV);
    }
    else {
        #| Run test cases
        use Test2::V0 qw( is plan );
        plan 3;

        is zero_array( 1, 5, 0, 3, 5 ), 3, 'works for (1, 5, 0, 3, 5)';
        is zero_array(0),               0, 'works for (0)';
        is zero_array( 2, 1, 4, 0, 3 ), 4, 'works for (2, 1, 4, 0, 3)';
    }
}

MAIN();
