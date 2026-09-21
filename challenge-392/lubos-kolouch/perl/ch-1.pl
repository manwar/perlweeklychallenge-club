#!/usr/bin/env perl
use v5.38;
use warnings;
use experimental 'signatures';

# Task 1: Make Palindrome
# Convert given string to palindrome by adding minimum characters in front of it.

sub make_palindrome ($str) {
    return $str if length($str) <= 1;

    my $n = length($str);

    # Find the longest palindromic prefix
    for my $len ( reverse 1 .. $n ) {
        my $prefix = substr( $str, 0, $len );
        if ( $prefix eq reverse($prefix) ) {
            my $suffix_to_add = substr( $str, $len );
            return reverse($suffix_to_add) . $str;
        }
    }

    return reverse( substr( $str, 1 ) ) . $str;
}

# Embedded tests
if ( !@ARGV ) {
    require Test::More;
    Test::More->import();

    is( make_palindrome("pinnipeds"),   "sdepinnipeds",   'Example 1' );
    is( make_palindrome("abcd"),        "dcbabcd",        'Example 2' );
    is( make_palindrome("bananas"),     "sananabananas",  'Example 3' );
    is( make_palindrome("dissident"),   "tnedissident",   'Example 4' );
    is( make_palindrome("cailliachs"),  "shcailliachs",   'Example 5' );
    is( make_palindrome("racecar"),     "racecar",        'Already palindrome' );
    is( make_palindrome("a"),           "a",              'Single char' );

    done_testing();
}
else {
    say make_palindrome( $ARGV[0] );
}
