#!/usr/bin/env perl

# You are given a positive integer, $int.

# Write a script to add thousand separator, , and return as string.

use 5.018;
use strict;
use warnings;
use Test2::V0;
use Data::Printer;

plan tests => 5;

sub thousand_separator {
    my $int = shift;

    print 'Input: $int = (' . $int . ")\n";
    my $result = "$int";

    my $thousands_re = qr{\B(?=(\d{3})+(?!\d))};
    $thousands_re = qr{\B(?<!\.\d{0,254})(?=(\d{3})+(?!\d))};
    $result =~ s{$thousands_re}{,}g;

    say 'Output: ' . $result;
    return $result;
}

my @examples = (

                {  in   => 123,
                   out  => "123",
                   name => 'example 1'
                },

                {  in   => 1234,
                   out  => "1,234",
                   name => 'example 2'
                },

                {  in   => 1000000,
                   out  => "1,000,000",
                   name => 'example 3'
                },

                {  in   => 1,
                   out  => "1",
                   name => 'example 4'
                },

                {  in   => 12345,
                   out  => "12,345",
                   name => 'example 5'
                },
               );

is( thousand_separator( $_->{ in } ), $_->{ out }, $_->{ name } )
    for @examples;

