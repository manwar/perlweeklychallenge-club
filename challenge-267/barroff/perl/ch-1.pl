#!/usr/bin/env perl

use v5.38;

sub product_sign (@ints) {
    if (grep { $_ == 0 } @ints) {
        return 0;
    }
    return grep( { $_ < 0 } @ints) % 2 == 0 ? 1 : -1;
}

sub MAIN() {
    if (@ARGV) {

        #| Run on command line argument
        say product_sign(@ARGV);
    }
    else {
        #| Run test cases
        use Test2::V0 qw( is plan );
        plan 3;
        is product_sign(-1, -2, -3, -4, 3, 2, 1), 1, 'works for (-1, -2, -3, -4, 3, 2, 1)';
        is product_sign(1, 2, 0, -2, -1), 0, 'works for (1, 2, 0, -2, -1)';
        is product_sign(-1, -1, 1, -1, 2), -1, 'works for (-1, -1, 1, -1, 2)';
    }
}

MAIN();
