#!/usr/bin/env perl

# You are given a string and a width.

# Write a script to return the string that centers the text within
# that width using asterisks * as padding.

use 5.018;
use strict;
use warnings;
use Test2::V0;

plan tests => 5;

sub text_justifier {
    my $str   = $_[0]->[0];
    my $width = $_[0]->[1];

    print 'Input: $str = "' . $str . '", $width = ' . $width . "\n";

    my $result = "*" x $width;
    my $offset = ( $width - length $str ) / 2;
    substr $result, $offset, length $str, $str;

    say 'Output: "' . $result . q{"};
    return $result;
}

my @examples = (
                 {  in   => [ "Hi", 5 ],
                    out  => "*Hi**",
                    name => 'example 1'
                 },
                 {  in   => [ "Code", 10 ],
                    out  => "***Code***",
                    name => 'example 2'
                 },
                 {  in   => [ "Hello", 9 ],
                    out  => "**Hello**",
                    name => 'example 3'
                 },
                 {  in   => [ "Perl", 4 ],
                    out  => "Perl",
                    name => 'example 4'
                 },
                 {  in   => [ "A", 7 ],
                    out  => "***A***",
                    name => 'example 5'
                 },
               );

is( text_justifier( $_->{ in } ), $_->{ out }, $_->{ name } ) for @examples;

