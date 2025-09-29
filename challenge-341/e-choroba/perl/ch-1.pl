#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub broken_keyboard($str, @keys) {
    my @words = split ' ', $str;
    return scalar @words unless @keys;

    my $regex = join "", @keys;
    return grep ! /[\Q$regex\E]/i, @words
}

use Test::More tests => 5;

is broken_keyboard('Hello World', 'd'), 1, 'Example 1';
is broken_keyboard('apple banana cherry', 'a', 'e'), 0, 'Example 2';
is broken_keyboard('Coding is fun'), 3, 'Example 3';
is broken_keyboard('The Weekly Challenge', 'a','b'), 2, 'Example 4';
is broken_keyboard('Perl and Python', 'p'), 1, 'Example 5';
