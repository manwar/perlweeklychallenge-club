#!/usr/bin/env perl
use v5.38;
use warnings;
use experimental 'signatures';

# Task 1: Reverse Substring
# Find whether any substring of length 2 of $str is present in reverse($str).

sub has_reverse_substring ($str) {
    my $len = length($str);
    return 0 if $len < 2;

    my $rev = reverse($str);

    for my $i ( 0 .. $len - 2 ) {
        my $sub = substr( $str, $i, 2 );
        return 1 if index( $rev, $sub ) != -1;
    }

    return 0;
}

# Embedded tests
if ( !@ARGV ) {
    require Test::More;
    Test::More->import();

    is( has_reverse_substring("abcba"),   1, 'Example 1' );
    is( has_reverse_substring("racecar"), 1, 'Example 2' );
    is( has_reverse_substring("abcd"),    0, 'Example 3' );
    is( has_reverse_substring("banana"),  1, 'Example 4' );
    is( has_reverse_substring("hello"),   1, 'Example 5' );

    done_testing();
}
else {
    say has_reverse_substring( $ARGV[0] ) ? 'true' : 'false';
}
