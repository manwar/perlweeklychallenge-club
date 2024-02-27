#!/usr/bin/env perl

use v5.38;

sub smaller_than_n( $n, @ints ) {
    scalar grep { $_ < $n } @ints;
}

sub smaller_than_current (@ints) {
    my @result = map( { smaller_than_n( $_, @ints ) } @ints );
    return \@result;
}

sub MAIN() {
    if (@ARGV) {

        #| Run on command line argument
        say smaller_than_current(@ARGV);
    }
    else {
        #| Run test cases
        use Test2::V0 qw( is plan );
        plan 4;
        is smaller_than_current( 5, 2, 1, 6 ), [ 2, 1, 0, 3 ],
          'works for (5, 2, 1, 6)';
        is smaller_than_current( 1, 2, 0, 3 ), [ 1, 2, 0, 3 ],
          'works for (1, 2, 0, 3)';
        is smaller_than_current( 0, 1 ), [ 0, 1 ], 'works for (0, 1)';
        is smaller_than_current( 9, 4, 9, 2 ), [ 2, 1, 2, 0 ],
          'works for (9, 4, 9, 2)';
    }
}

MAIN();
