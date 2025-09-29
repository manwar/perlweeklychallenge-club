#!/usr/bin/env perl

use strict;
use warnings;
use v5.10;

# Module docstring
# Task 2: Reverse Prefix
# Given a string and a character, reverses the prefix up to the first occurrence of the character.

sub reverse_prefix {
    my ( $str, $char ) = @_;

    # Find position of first occurrence of char
    my $pos = index( $str, $char );

    # If char not found, return original string
    return $str if $pos == -1;

    # Get prefix up to and including char
    my $prefix = substr( $str, 0, $pos + 1 );

    # Reverse prefix and append rest of string
    return reverse($prefix) . substr( $str, $pos + 1 );
}

# Unit tests
use Test::More tests => 5;

is( reverse_prefix( 'programming', 'g' ), 'gorpramming', 'Example 1: programming, g' );
is( reverse_prefix( 'hello',       'h' ), 'hello',       'Example 2: hello, h' );
is( reverse_prefix( 'abcdefghij',  'h' ), 'hgfedcbaij',  'Example 3: abcdefghij, h' );
is( reverse_prefix( 'reverse',     's' ), 'srevere',     'Example 4: reverse, s' );
is( reverse_prefix( 'perl',        'r' ), 'repl',        'Example 5: perl, r' );
