#!/usr/bin/env perl

use strict;
use warnings;
use v5.10;

# Module docstring
# Task 1: Broken Keyboard
# Given a string and a list of broken keys, returns the count of words that can be typed completely.

sub broken_keyboard {
    my ( $str, @broken_keys ) = @_;

    # Convert broken keys to a hash for O(1) lookup
    my %broken = map { $_ => 1 } @broken_keys;

    # Split string into words
    my @words = split /\s+/, $str;
    my $count = 0;

    # Check each word
    foreach my $word (@words) {
        my $can_type = 1;

        # Check if word contains any broken key
        foreach my $char ( split //, lc($word) ) {
            if ( exists $broken{$char} ) {
                $can_type = 0;
                last;
            }
        }
        $count++ if $can_type;
    }

    return $count;
}

# Unit tests
use Test::More tests => 5;

is( broken_keyboard( 'Hello World', 'd' ),               1, 'Example 1: Hello World, d broken' );
is( broken_keyboard( 'apple banana cherry', 'a', 'e' ),  0, 'Example 2: apple banana cherry, a,e broken' );
is( broken_keyboard( 'Coding is fun', () ),              3, 'Example 3: Coding is fun, no broken keys' );
is( broken_keyboard( 'The Weekly Challenge', 'a', 'b' ), 2, 'Example 4: The Weekly Challenge, a,b broken' );
is( broken_keyboard( 'Perl and Python', 'p' ),           1, 'Example 5: Perl and Python, p broken' );
