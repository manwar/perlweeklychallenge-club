#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub count_vowel($str) {
    my @s;
    while ($str =~ /(?=([aeiou]+))/g) {
        my $long_substr = $1;
        for my $l (5 .. length $long_substr) {
            my $short = substr $long_substr, 0, $l;
            push @s, $short if has_all($short);
        }
    }
    return @s
}

sub has_all($s) {
    5 == grep $s =~ $_, qw( a e i o u )
}

use Test2::V0;
plan(5);

is [count_vowel('aeiou')], ['aeiou'], 'Example 1';

is [count_vowel('aaeeeiioouu')],
    bag { item $_ for qw( aaeeeiioou aaeeeiioouu aeeeiioou aeeeiioouu ); end },
    'Example 2';

is [count_vowel('aeiouuaxaeiou')],
    bag { item $_ for qw( aeiou aeiou eiouua aeiouu aeiouua ); end },
    'Example 3';

is [count_vowel('uaeiou')],
    bag { item $_ for qw( aeiou uaeio uaeiou ); end },
    'Example 4';

is [count_vowel('aeioaeioa')], [], 'Example 5';
