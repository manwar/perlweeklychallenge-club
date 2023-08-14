#!/usr/bin/env perl

use v5.38;

sub is_lexicographic ($word) {
    my $sorted_string = join( '', sort( split( '', $word ) ) );
    $sorted_string eq $word || reverse($sorted_string) eq $word ? 1 : 0;
}

sub lexicographic_order (@words) {
    scalar grep { !is_lexicographic($_) } @words;
}

sub MAIN() {
    if (@ARGV) {

        #| Run command line arguments
        say lexicographic_order(@ARGV);
    }
    else {
        #| Run test cases
        use Test2::V0 qw( is plan );
        plan 2;

        is lexicographic_order( "abc", "bce", "cae" ), 1,
          'works for ("abc", "bce", "cae")';
        is lexicographic_order( "yxz", "cba", "mon" ), 2,
          'works for ("yxz", "cba", "mon")';
    }
}

MAIN();
