#!/usr/bin/env perl

use v5.38;

use List::Util qw/sum/;

sub build_array (@ints) {
    my @result =
      map( { $ints[$_] >= @ints ? undef : $ints[ $ints[$_] ] } 0 .. @ints - 1 );
    return \@result;
}

sub MAIN() {
    if (@ARGV) {

        #| Run command line arguments
        say build_array(@ARGV);
    }
    else {
        #| Run test cases
        use Test2::V0 qw( is plan );
        plan 2;

        is build_array( 0, 2, 1, 5, 3, 4 ), [ 0, 1, 2, 4, 5, 3 ],
          'works for (0, 2, 1, 5, 3, 4)';
        is build_array( 5, 0, 1, 2, 3, 4 ), [ 4, 5, 0, 1, 2, 3 ],
          'works for (5, 0, 1, 2, 3, 4)';
    }
}

MAIN();
