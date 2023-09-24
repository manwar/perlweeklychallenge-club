#!/usr/bin/env perl

use v5.38;

use List::Util qw/sum/;

sub remove_one (@ints) {
    return 1 if @ints < 3;
    my @comparisons =
      map( { $ints[$_] < $ints[ $_ + 1 ] ? 0 : 1 } 0 .. @ints - 2 );
    return sum(@comparisons) < 2 ? 1 : 0;
}

sub MAIN() {
    if (@ARGV) {

        #| Run command line arguments
        say remove_one(@ARGV);
    }
    else {
        #| Run test cases
        use Test2::V0 qw( is plan );
        plan 3;

        is remove_one( ( 0, 2, 9, 4, 6 ) ), 1, 'works for (0, 2, 9, 4, 6)';
        is remove_one( ( 5, 1, 3, 2 ) ),    0, 'works for (5, 1, 3, 2)';
        is remove_one( ( 2, 2, 3 ) ),       1, 'works for (2, 2, 3)';
    }
}

MAIN();
