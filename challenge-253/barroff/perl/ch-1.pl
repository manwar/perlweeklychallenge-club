#!/usr/bin/env perl

use v5.38;

sub split_strings ( $separator, @words ) {
    my @res = grep( { length($_) > 0 }
        map( { split( /\Q$separator\E/, $_ ) } @words ) );

    return \@res;
}

sub MAIN() {
    if (@ARGV) {

        #| Run on command line argument
        say split_strings( $ARGV[1], @ARGV[ 2 .. -1 ] );
    }
    else {
        #| Run test cases
        use Test2::V0 qw( is plan );
        plan 2;

        is split_strings( ".", ( "one.two.three", "four.five", "six" ) ),
          [ "one", "two", "three", "four", "five", "six" ],
          'works for ("one.two.three","four.five","six")';
        is split_strings( '$', ( '$perl$$', '$$raku$' ) ), [ "perl", "raku" ],
          'works for ("$perl$$", "$$raku$")';
    }
}

MAIN();
