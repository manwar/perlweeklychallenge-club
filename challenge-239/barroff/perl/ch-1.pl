#!/usr/bin/env perl

use v5.38;

use List::Util qw/sum/;

sub same_string ( $arr1, $arr2 ) {
    join( '', @$arr1 ) eq join( '', @$arr2 ) ? 1 : 0;
}

sub MAIN() {

    # if (@ARGV) {
    #
    #     #| Run command line arguments
    #     say same_string(@ARGV);
    # }
    # else {
    #| Run test cases
    use Test2::V0 qw( is plan );
    plan 3;

    is same_string( [ "ab", "c" ], [ "a", "bc" ] ), 1,
      'works for ([ "ab", "c" ], [ "a", "bc" ])';
    is same_string( [ "ab", "c" ], [ "ac", "b" ] ), 0,
      'works for ([ "ab", "c" ], [ "ac", "b" ])';
    is same_string( [ "ab", "cd", "e" ], ["abcde"] ), 1,
      'works for ([ "ab", "cd", "e" ], ["abcde"])';

    # }
}

MAIN();
