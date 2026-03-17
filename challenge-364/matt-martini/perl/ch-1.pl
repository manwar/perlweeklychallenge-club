#!/usr/bin/env perl

# You are given a string formed by digits and ‘#'.

# Write a script to map the given string to English lowercase characters
# following the given rules.

# - Characters 'a' to 'i' are represented by '1' to '9' respectively.
# - Characters 'j' to 'z' are represented by '10#' to '26#' respectively.

use 5.018;
use strict;
use warnings;
use utf8;
use open qw(:std :utf8);
use Test2::V0;

plan tests => 5;

sub num_2_alpha {
    my $num = shift;
    return unless defined $num;
    return chr( ord('a') + $num - 1 );
}

sub decrypt_string {
    my $str = shift;
    say 'Input: $str = "' . $str . q{"};

    my $result = q{};

    my $atoj_re  = qr{(\d)(?!\d#)};
    my $jplus_re = qr{(\d\d)#};

    DIGIT:
    while ( length $str > 0 ) {
        if (( $str =~ s/^$atoj_re// ) || ( $str =~ s/^$jplus_re// )) {
            $result .= num_2_alpha($1);
            next DIGIT;
        }
        warn "Invalid string format\n";
        last;
    }

    say 'Output: "' . $result . q{"};
    return $result;
}

my @examples = (
                 {  in   => '10#11#12',
                    out  => 'jkab',
                    name => 'example 1'
                 },
                 {  in   => '1326#',
                    out  => 'acz',
                    name => 'example 2'
                 },
                 {  in   => '25#24#123',
                    out  => 'yxabc',
                    name => 'example 3'
                 },
                 {  in   => '20#5',
                    out  => 'te',
                    name => 'example 4'
                 },
                 {  in   => '1910#26#',
                    out  => 'aijz',
                    name => 'example 5'
                 },
               );

is( decrypt_string( $_->{ in } ), $_->{ out }, $_->{ name } )
    for @examples;
