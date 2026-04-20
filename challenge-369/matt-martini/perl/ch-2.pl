#!/usr/bin/env perl

# You are given a string, group size and filler character.

# Write a script to divide the string into groups of given size. In the
# last group if the string doesn’t have enough characters remaining fill
# with the given filler character.

use 5.018;
use strict;
use warnings;
use Test2::V0;

plan tests => 5;

sub group_division {
    my ( $str, $size, $filler ) = @{ $_[0] };

    my @results = ();
    printf qq{ Input: \$str = "%s", \$size = %d, \$filler = "%s"\n }, $str,
        $size, $filler;

    while(length $str >= $size){
        push @results, substr($str,0,$size,'');
    }
    my $strlen = length $str;
    if ($strlen != 0){
        push @results, $str . $filler x ($size - $strlen);
    }

    printf qq{Output: ("%s")\n}, join('", "', @results);
    return \@results;
}

my @examples = (
                 {  in   => [ "RakuPerl", 4, "*" ],
                    out  => [ "Raku",     "Perl" ],
                    name => 'example 1'
                 },
                 {  in   => [ "Python", 5, "0" ],
                    out  => [ "Pytho",  "n0000" ],
                    name => 'example 2'
                 },
                 {  in   => [ "12345", 3, "x" ],
                    out  => [ "123",   "45x" ],
                    name => 'example 3'
                 },
                 {  in   => [ "HelloWorld", 3, "_" ],
                    out  => [ "Hel", "loW", "orl", "d__" ],
                    name => 'example 4'
                 },
                 {  in   => [ "AI", 5, "!" ],
                    out  => ["AI!!!"],
                    name => 'example 5'
                 },
               );

is( group_division( $_->{ in } ), $_->{ out }, $_->{ name } )
    for @examples;
