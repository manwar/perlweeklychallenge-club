#!/usr/bin/env perl

use v5.38;

use List::Util qw( min first );

sub empty_array (@ints) {
    return 1 if 1 >= @ints;
    my $minimum = min @ints;
    my $key     = first { $ints[$_] == $minimum } keys @ints;
    my @new_ints;
    if ( $key == 0 ) {
        @new_ints = @ints[ 1 .. @ints - 1 ];
    }
    elsif ( $key == @ints - 1 ) {
        @new_ints = ( @ints[ 0 .. @ints - 2 ] );
    }
    else {
        @new_ints = ( @ints[ $key + 1 .. @ints - 1 ], @ints[ 0 .. $key - 1 ] );
    }
    return 1 + $key + empty_array(@new_ints);
}

sub MAIN() {
    if (@ARGV) {

        #| Run command line arguments
        say empty_array(@ARGV);
    }
    else {
        #| Run test cases
        use Test2::V0 qw( is plan );
        plan 3;

        is empty_array( ( 3, 4, 2 ) ), 5, 'works for (3, 4, 2)';
        is empty_array( ( 1, 2, 3 ) ), 3, 'works for (1, 2, 3)';
        is empty_array( ( 2, 1, 3 ) ), 5, 'works for (2, 1, 3)';
    }
}

MAIN();
