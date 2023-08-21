#!/usr/bin/env perl

use v5.38;

sub count_words ( $prefix, @words ) {
    scalar( grep { /^ $prefix /x } @words );
}

sub MAIN() {

    #| Run test cases
    use Test2::V0 qw( is plan );
    plan 2;

    is count_words( 'at', ( "pay", "attention", "practice", "attend" ) ), 2,
      'works for ("pay", "attention", "practice", "attend")';
    is count_words( ( 'ja', "janet", "julia", "java", "javascript" ) ), 3,
      'works for ("janet", "julia", "java", "javascript")';
}

MAIN();
