#!/usr/bin/env perl

use v5.38;

use List::Util qw/sum/;

sub special_numbers (@ints) {
    sum( map( { $ints[ $_ - 1 ]**2 } grep( { @ints % $_ == 0 } 1 .. @ints ) ) );
}

sub MAIN() {
    if (@ARGV) {

        #| Run on command line argument
        say special_numbers(@ARGV);
    }
    else {
        #| Run test cases
        use Test2::V0 qw( is plan );
        plan 2;
        is special_numbers( ( 1, 2, 3, 4 ) ), 21, 'Works for (1, 2, 3, 4)';
        is special_numbers( ( 2, 7, 1, 19, 18, 3 ) ), 63,
          'Works for (2, 7, 1, 19, 18, 3)';
    }
}

MAIN();
