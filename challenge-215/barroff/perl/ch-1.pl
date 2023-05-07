#!/usr/bin/env perl

use v5.36;
use strict;
use warnings;

sub is_alphabetic ($s) {
    return $s eq join( '', sort( split( //, $s ) ) );
}

sub odd_one_out (@words) {
    my @sorted_words = grep is_alphabetic($_), @words;
    return $#words - $#sorted_words;
}

#| Run test cases
sub MAIN() {
    use Test2::V0 qw(is plan);
    plan 3;

    is odd_one_out( 'abc', 'xyz', 'tsu' ), 1, "works for ('abc', 'xyz', 'tsu')";
    is odd_one_out( 'rat', 'cab', 'dad' ), 3, "works for ('rat', 'cab', 'dad')";
    is odd_one_out( 'x',   'y',   'z' ),   0, "works for ('x', 'y', 'z')";
}

MAIN();
