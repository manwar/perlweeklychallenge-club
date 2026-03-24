#!/usr/bin/env perl

# You are given an array of words and a string (contains only lowercase
# English letters).

# Write a script to return the number of words in the given array that are
# a prefix of the given string.

use 5.018;
use strict;
use warnings;
use Test2::V0;

plan tests => 5;

sub count_prefixes {
    my @array = @{ $_[0]->[0] };
    my $str   = $_[0]->[1];
    printf qq{ Input: \@array = ("%s"), \$str = "%s"\n }, join( '", "', @array ),
        $str;

    my $result = 0;
    for (@array) {
        $result++ if ( $_ eq substr( $str, 0, length($_) ) );
    }

    printf qq{Output: %d\n}, $result;
    return $result;
}

my @examples = (

                {  in   => [ [ "a", "ap", "app", "apple", "banana" ], "apple" ],
                   out  => 4,
                   name => 'example 1'
                },

                {  in   => [ [ "cat", "dog", "fish" ], "bird" ],
                   out  => 0,
                   name => 'example 2'
                },

                {
                   in   => [ [ "hello", "he", "hell", "heaven", "he" ], "hello" ],
                   out  => 4,
                   name => 'example 3'
                },

                {  in   => [ [ "", "code", "coding", "cod" ], "coding" ],
                   out  => 3,
                   name => 'example 4'
                },

                {  in => [
                           [ "p", "pr", "pro", "prog", "progr", "progra", "program" ],
                           "program"
                         ],
                   out  => 7,
                   name => 'example 5'
                },
               );

is( count_prefixes( $_->{ in } ), $_->{ out }, $_->{ name } ) for @examples;
