#!/usr/bin/env perl

use v5.38;

sub six_out_of_fortynine ( $count = 6 ) {
    my %numbers;
    $numbers{$_} = rand() for 1 .. 49;
    my @keys = sort { $numbers{$a} <=> $numbers{$b} } keys(%numbers);
    say for @keys[ 0 .. $count - 1 ];
    return undef;
}

sub MAIN() {
    if (@ARGV) {

        #| Run command line argument
        die "Number <$ARGV[0]> is not in range 1-49!"
          if $ARGV[0] < 1
          or $ARGV[0] > 49;
        six_out_of_fortynine( $ARGV[0] );
    }
    else {
        #| Run default case
        six_out_of_fortynine();
    }
}

MAIN();
