#!/usr/bin/env perl

# You are given an array of integers, @ints.

# Write a script to return true if the given array is a valid mountain array.

#   An array is mountain if and only if:
#   1) arr.length >= 3
#   and
#   2) There exists some i with 0 < i < arr.length - 1 such that:
#   arr[0] < arr[1]     < ... < arr[i - 1] < arr[i]
#   arr[i] > arr[i + 1] > ... > arr[arr.length - 1]

use 5.018;
use strict;
use warnings;
use Test2::V0;
use List::Util qw(reduce);

plan tests => 5;

sub mountain_array {
    my (@ints) = @{ $_[0] };

    print 'Input: @ints = (' . join( ', ', @ints ) . ")\n";
    my $result = "false";

    if ( scalar @ints >= 3 ) {
        SCAN:
        for my $index ( 1 .. $#ints - 1 ) {
            my $pre  = reduce { $a < $b ? $b : "inf" } @ints[ 0 .. $index ];
            my $post = reduce { $a > $b ? $a : "-inf" } @ints[ $index .. $#ints ];
            if ( $pre == $post ) {
                $result = "true";
                last SCAN;
            }
        }
    }

    say 'Output: ' . $result;
    return $result;
}

my @examples = (

                {  in   => [ 1, 2, 3, 4, 5 ],
                   out  => "false",
                   name => 'example 1'
                },

                {  in   => [ 0, 2, 4, 6, 4, 2, 0 ],
                   out  => "true",
                   name => 'example 2'
                },

                {  in   => [ 5, 4, 3, 2, 1 ],
                   out  => "false",
                   name => 'example 3'
                },

                {  in   => [ 1, 3, 5, 5, 4, 2 ],
                   out  => "false",
                   name => 'example 4'
                },

                {  in   => [ 1, 3, 2 ],
                   out  => "true",
                   name => 'example 5'
                },
               );

is( mountain_array( $_->{ in } ), $_->{ out }, $_->{ name } ) for @examples;

