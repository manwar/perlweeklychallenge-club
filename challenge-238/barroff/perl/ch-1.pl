#!/usr/bin/env perl

use v5.38;

use List::Util qw/sum/;

sub running_sum ( $rs, @ints ) {
    return $rs + $ints[0] if @ints == 1;
    return (
        ( $rs + $ints[0], running_sum( $rs + $ints[0], @ints[ 1 .. $#ints ] ) )
    );
}

sub MAIN() {
    if (@ARGV) {

        #| Run command line arguments
        say running_sum(@ARGV);
    }
    else {
        #| Run test cases
        use Test2::V0 qw( is plan );
        plan 3;

        is eval 'join " ", running_sum(0, ( 1, 2, 3, 4, 5 ) )',
          '1 3 6 10 15', 'works for (1, 2, 3, 4, 5)';
        is eval 'join " ", running_sum(0, ( 1, 1, 1, 1, 1 ) )',
          '1 2 3 4 5', 'works for (1, 1, 1, 1, 1)';
        is eval 'join " ", running_sum(0, ( 0, -1, 1, 2) )',
          '0 -1 0 2', 'works for (0, -1, 1, 2)';
    }
}

MAIN();
