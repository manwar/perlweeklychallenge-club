#!/usr/bin/env perl

use v5.38;

sub maximum_pairs (@words) {
    use List::Util qw/any/;
    my @non_palindromes = grep { $_ ne reverse $_ } @words;
    my @reversed_words  = map  { scalar reverse $_ } @non_palindromes;
    grep( {
            my $outer = $_;
            any { $outer eq $_ } @words
    } @reversed_words ) / 2;
}

sub MAIN() {
    if ( @ARGV > 1 ) {

        #| Run on command line argument
        say maximum_pairs( @ARGV[ 1 .. -1 ] );
    }
    else {
        #| Run test cases
        use Test2::V0 qw( is plan );
        plan 3;

        is maximum_pairs( "ab", "de", "ed", "bc" ), 1,
          'works for "ab", "de", "ed", "bc"';
        is maximum_pairs( "aa", "ba", "cd", "ed" ), 0,
          'works for "aa", "ba", "cd", "ed"';
        is maximum_pairs( "uv", "qp", "st", "vu", "mn", "pq" ), 2,
          'works for "uv", "qp", "st", "vu", "mn", "pq"';
    }
}

MAIN();
