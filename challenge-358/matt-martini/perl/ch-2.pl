#!/usr/bin/env perl

# You are given a string $str and an integer $int.

# Write a script to encrypt the string using the algorithm -
# for each character $char in $str, replace $char with the $int th
# character after $char in the alphabet, wrapping if needed and
# return the encrypted string.

use 5.018;
use strict;
use warnings;
use utf8;
use open qw(:std :utf8);
use Test2::V0;
use Data::Printer;

plan tests => 5;

sub encrypted_string {
    my $str = $_[0]->[0];
    my $int = $_[0]->[1];

    print 'Input: $str = "' . $str . '", $int = ' . $int . "\n";

    $int = $int % 26;

    my $result = q{};
    for my $i ( 0 .. length($str)-1  ) {
        my $char = substr( $str, $i, 1 );
        my $char_num = ord($char) + $int;
        $char = chr( $char_num > 122 ? $char_num - 26 : $char_num);
        $result .= $char;
    }

    say 'Output: "' . $result . q{"};
    return $result;
}

my @examples = (

                {  in   => [ "abc", 1 ],
                   out  => "bcd",
                   name => 'example 1'
                },

                {  in   => [ "xyz", 2 ],
                   out  => "zab",
                   name => 'example 2'
                },

                {  in   => [ "abc", 27 ],
                   out  => "bcd",
                   name => 'example 3'
                },

                {  in   => [ "hello", 5 ],
                   out  => "mjqqt",
                   name => 'example 4'
                },

                {  in   => [ "perl", 26 ],
                   out  => "perl",
                   name => 'example 5'
                },
               );

is( encrypted_string( $_->{ in } ), $_->{ out }, $_->{ name } ) for @examples;

