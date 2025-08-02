#!/usr/bin/env perl

use v5.38;

sub b_after_a ($str) {
    return $str =~ /^a*b+$/ ? 1 : 0;
}

sub MAIN() {
    if (@ARGV) {

        #| Run on command line argument
        say b_after_a( $ARGV[0] );
    }
    else {
        #| Run test cases
        use Test2::V0 qw( is plan );
        plan 4;
        is b_after_a('aabb'), 1, 'works for "aabb';
        is b_after_a('abab'), 0, 'works for "abab';
        is b_after_a('aaa'),  0, 'works for "aaa';
        is b_after_a('bbb'),  1, 'works for "bbb';
    }
}

MAIN();

