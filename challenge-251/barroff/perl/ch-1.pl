#!/usr/bin/env perl

use v5.38;

use List::Util qw/sum/;

sub concatenation_value (@ints) {
    if ( @ints % 2 == 0 ) {
        return sum(
            map( { $ints[$_] . $ints[ -$_ - 1 ] } 0 .. @ints / 2 - 1 ) );
    }
    else {
        my $mid = int( @ints / 2 );
        return sum( map( { $ints[$_] . $ints[ -$_ - 1 ] } 0 .. $mid - 1 ) ) +
          $ints[$mid];
    }
}

sub MAIN() {
    if (@ARGV) {

        #| Run on command line argument
        say concatenation_value(@ARGV);
    }
    else {
        #| Run test cases
        use Test2::V0 qw( is plan );
        plan 3;
        is concatenation_value( ( 6, 12, 25, 1 ) ), 1286,
          'works for (6, 12, 25, 1)';
        is concatenation_value( ( 10, 7, 31, 5, 2, 2 ) ), 489,
          'works for (10, 7, 31, 5, 2, 2)';
        is concatenation_value( ( 1, 2, 10 ) ), 112, 'works for (1, 2, 10)';
    }
}

MAIN();
