#!/usr/bin/env perl

# You are give a sentence.

# Write a script to order words in the given sentence alphabetically
# but keeps the words themselves unchanged.

use 5.018;
use strict;
use warnings;
use Test2::V0;

plan tests => 5;

sub encrypted_string {
    my $str    = shift;
    my $result = q{};

    print 'Input: $str = "' . $str . '"' . "\n";

    my @words = split /\s+/, $str;
    $result = join q{ }, sort { fc($a) cmp fc($b) } @words;

    say 'Output: "' . $result . q{"};
    return $result;
}

my @examples = (
                 {  in   => "The quick brown fox",
                    out  => "brown fox quick The",
                    name => 'example 1'
                 },
                 {  in   => "Hello    World!   How   are you?",
                    out  => "are Hello How World! you?",
                    name => 'example 2'
                 },
                 {  in   => "Hello",
                    out  => "Hello",
                    name => 'example 3'
                 },
                 {  in   => "Hello, World! How are you?",
                    out  => "are Hello, How World! you?",
                    name => 'example 4'
                 },
                 {  in   => "I have 2 apples and 3 bananas!",
                    out  => "2 3 and apples bananas! have I",
                    name => 'example 5'
                 },
               );

is( encrypted_string( $_->{ in } ), $_->{ out }, $_->{ name } ) for @examples;

