#!/usr/bin/env perl

# You are given a string, $str.

# Write a script to interpret the given string using Goal Parser.

#     The Goal Parser interprets “G” as the string “G”, “()” as the string “o”,
#     and “(al)” as the string “al”. The interpreted strings are then
#     concatenated in the original order.

use 5.018;
use strict;
use warnings;
use utf8;
use open qw(:std :utf8);
use Test2::V0;

plan tests => 5;

sub goal_parser {
    my $str = shift;
    say 'Input: $str = "' . $str . q{"};

    my $result = q{};

    my $g_re  = q{^G};
    my $o_re  = q{^\(\)};
    my $al_re = q{^\(al\)};

    LETTER:
    while ( length $str > 0 ) {
        if ( $str =~ s/$g_re// ) {
            $result .= 'G';
        }
        elsif ( $str =~ s/$o_re// ) {
            $result .= 'o';
        }
        elsif ( $str =~ s/$al_re// ) {
            $result .= 'al';
        }
        else {
            warn "Invalid input\n";
            last;
        }
    }
    say 'Output: ' . $result;
    return $result;
}

my @examples = (
                 {  in   => 'G()(al)',
                    out  => 'Goal',
                    name => 'example 1'
                 },
                 {  in   => 'G()()()()(al)',
                    out  => 'Gooooal',
                    name => 'example 2'
                 },
                 {  in   => '(al)G(al)()()',
                    out  => 'alGaloo',
                    name => 'example 3'
                 },
                 {  in   => '()G()G',
                    out  => 'oGoG',
                    name => 'example 4'
                 },
                 {  in   => '(al)(al)G()()',
                    out  => 'alalGoo',
                    name => 'example 5'
                 },
               );

is( goal_parser( $_->{ in } ), $_->{ out }, $_->{ name } )
    for @examples;

