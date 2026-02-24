#!/usr/bin/env perl

# You are given a string containing lowercase letters.

# Write a script to transform the string based on the index
# position of each character (starting from 0). For each
# character at position i, repeat it i + 1 times.

use 5.018;
use strict;
use warnings;
use Test2::V0;

plan tests => 5;

sub echo_chamber {
    my $str = shift;
    print 'Input: "' . $str . q{"};

    my $result = q{};
    for my $i ( 0 .. length($str) ) {
        $result .= substr( $str, $i, 1 ) x ( $i + 1 );
    }

    say 'Output: "' . $result . q{"};
    return $result;
}

my @examples = (
                 { in => "abca", out => "abbcccaaaa", name => 'example 1' },
                 { in => "xyz",  out => "xyyzzz",     name => 'example 2' },
                 { in => "code", out => "coodddeeee", name => 'example 3' },
                 {  in   => "hello",
                    out  => "heelllllllooooo",
                    name => 'example 4'
                 },
                 { in => "a", out => "a", name => 'example 5' },
               );

is( echo_chamber( $_->{ in } ), $_->{ out }, $_->{ name } ) for @examples;

