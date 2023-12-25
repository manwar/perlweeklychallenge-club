#!/usr/bin/env perl

use v5.38;

sub minimal_distance ( $start, @positions ) {
    use List::Util qw / min /;
    min( map( { abs( $start - $_ ) } @positions ) );
}

sub shortest_distance ( $str, $char ) {
    my @split_str = split( //, $str );
    my %indices;
    $indices{$_}++ for grep( { $split_str[$_] eq $char } 0 .. $#split_str );
    return () unless %indices;
    my @result =
      map( { exists $indices{$_} ? 0 : minimal_distance( $_, keys %indices ) }
        0 .. $#split_str );
    return \@result;
}

sub MAIN() {
    if (@ARGV) {

        #| Run on command line argument
        say shortest_distance( $ARGV[0], @ARGV[ 1 .. -1 ] );
    }
    else {
        #| Run test cases
        use Test2::V0 qw( is plan );
        plan 2;

        is shortest_distance( 'loveleetcode', 'e' ),
          [ 3, 2, 1, 0, 1, 0, 0, 1, 2, 2, 1, 0 ],
          "works for ('loveleetcode', 'e')";
        is shortest_distance( 'aaab', 'b' ), [ 3, 2, 1, 0 ],
          "works for ('aaab', 'b')";
    }
}

MAIN();
