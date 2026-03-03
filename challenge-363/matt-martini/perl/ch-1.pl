#!/usr/bin/env perl

# You are given a string.

# Write a script that parses a self-referential string and determines
# whether its claims about itself are true. The string will make
# statements about its own composition, specifically the number of vowels
# and consonants it contains.

use 5.018;
use strict;
use warnings;
use utf8;
use open qw(:std :utf8);
use Test2::V0;

plan tests => 5;

sub string_lie_detector {
    my $str = shift;
    say 'Input: $str = "' . $str . q{"};

    my $result     = 'false';
    my $vowels     = 0;
    my $consonants = 0;

    my $vowel_re = qr{[aeiou]};
    my $alpha_re = qr{[[:alpha:]]};
    my $claim_re = qr{(.*?) vowel(?:s)* and (.*?) consonant(?:s)*};

    my %nums = (
                 zero  => 0,
                 one   => 1,
                 two   => 2,
                 three => 3,
                 four  => 4,
                 five  => 5,
                 six   => 6,
                 seven => 7,
                 eight => 8,
                 nine  => 9,
                 ten   => 10,
               );

    my ( $statement, $claim ) = split ' — ', $str;
    my ( $v_claim, $c_claim ) = $claim =~ $claim_re;
    $v_claim = $nums{ $v_claim };
    $c_claim = $nums{ $c_claim };

    LETTER:
    while ( $statement =~ m|(.)|g ) {
        my $ltr = $1;
        next LETTER if ( $ltr !~ $alpha_re );
        $ltr =~ $vowel_re ? $vowels++ : $consonants++;
    }

    $result = 'true' if ( $v_claim == $vowels ) && ( $c_claim == $consonants );

    say 'Output: ' . $result;
    return $result;
}

my @examples = (
                 {  in   => 'aa — two vowels and zero consonants',
                    out  => 'true',
                    name => 'example 1'
                 },
                 {  in   => 'iv — one vowel and one consonant',
                    out  => 'true',
                    name => 'example 2'
                 },
                 {  in   => 'hello — three vowels and two consonants',
                    out  => 'false',
                    name => 'example 3'
                 },
                 {  in   => 'aeiou — five vowels and zero consonants',
                    out  => 'true',
                    name => 'example 4'
                 },
                 {  in   => 'aei — three vowels and zero consonants',
                    out  => 'true',
                    name => 'example 5'
                 },
               );

is( string_lie_detector( $_->{ in } ), $_->{ out }, $_->{ name } )
    for @examples;

