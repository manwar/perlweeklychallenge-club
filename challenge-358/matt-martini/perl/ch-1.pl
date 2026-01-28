#!/usr/bin/env perl

# You are given an array of alphanumeric string, @strings.

# Write a script to find the max value of alphanumeric string in the given array.
# The numeric representation of the string, if it comprises of digits only otherwise
# length of the string.

use 5.018;
use strict;
use warnings;
use Test2::V0;

plan tests => 5;

my $numbers_only_re = qr{^\d+$};

sub max_str_value {
    my @strings = @{ $_[0] };
    print 'Input: @strings = ("' . join( '", "', @strings ) . qq{")\n};

    my $max = 0;

    foreach my $string (@strings) {
        my $value = ( $string =~ m{$numbers_only_re} ? $string + 0 : length $string );
        $max = $value if ( $value > $max );
    }

    say 'Output: ' . $max;
    return $max;
}

my @examples = (

                {  in   => [ "123", "45", "6" ],
                   out  => 123,
                   name => 'example 1'
                },

                {  in   => [ "abc", "de", "fghi" ],
                   out  => 4,
                   name => 'example 2'
                },

                {  in   => [ "0012", "99", "a1b2c" ],
                   out  => 99,
                   name => 'example 3'
                },

                {  in   => [ "x", "10", "xyz", "007" ],
                   out  => 10,
                   name => 'example 4'
                },

                {  in   => [ "hello123", "2026", "perl" ],
                   out  => 2026,
                   name => 'example 5'
                },
               );

is( max_str_value( $_->{ in } ), $_->{ out }, $_->{ name } ) for @examples;

