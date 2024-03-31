#!/usr/bin/env perl

use v5.38;

sub max_positive_negative (@ints) {
    use List::Util qw /max/;
    max(
        scalar( grep( { $_ > 0 } @ints ) ),
        scalar( grep( { $_ < 0 } @ints ) )
    );
}

sub MAIN() {
    if (@ARGV) {

        #| Run on command line argument
        say max_positive_negative(@ARGV);
    }
    else {
        #| Run test cases
        use Test2::V0 qw( is plan );
        plan 3;
        is max_positive_negative( -3, 1, 2, -1, 3, -2, 4 ), 4,
          'works for (-3, 1, 2, -1, 3, -2, 4)';
        is max_positive_negative( -1, -2, -3, 1 ), 3,
          'works for (-1, -2, -3, 1)';
        is max_positive_negative( 1, 2 ), 2, 'works for (1, 2)';
    }
}

MAIN();
