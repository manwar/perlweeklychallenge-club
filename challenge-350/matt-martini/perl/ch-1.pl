#!/usr/bin/env perl

# You are given a string.

# Write a script to return the number of good substrings of length three in the given string.

#     A string is good if there are no repeated characters.

use 5.018;
use strict;
use warnings;
use Test2::V0;
use List::Util qw(min max sum0);
use Data::Printer;

plan tests => 5;

sub good_substrings {
    my $str = shift;

    print 'Input: $str = (' . $str . ")\n";

    my $result = 0;
    for my $i ( 0 .. length($str) - 3 ) {
        my $sub = substr( $str, $i, 3 );
        unless ( $sub =~ m{([[:alpha:]]).*\1+} ) {
            $result++;
        }
    }

    say 'Output: ' . $result;
    return $result;
}

my @examples = (

                {  in   => "abcaefg",
                   out  => 5,
                   name => 'example 1'
                },

                {  in   => "xyzzabc",
                   out  => 3,
                   name => 'example 2'
                },

                {  in   => "aababc",
                   out  => 1,
                   name => 'example 3'
                },

                {  in   => "qwerty",
                   out  => 4,
                   name => 'example 4'
                },

                {  in   => "zzzaaa",
                   out  => 0,
                   name => 'example 5'
                },
               );

is( good_substrings( $_->{ in } ), $_->{ out }, $_->{name} ) for @examples;

