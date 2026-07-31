#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::Util qw{ min };

sub special_binary_substrings($binary) {
    my %sbs;
    while ($binary =~ /(?|(0+)(?=(1+))|(1+)(?=(0+)))/g) {
        for my $length (1 .. min(map length, $1, $2)) {
            undef $sbs{ substr($1, 0, $length) . substr($2, 0, $length) }
        }
    }
    return keys %sbs
}

use Test2::V0;
plan(5);

is [special_binary_substrings('0101')],
    bag { item $_ for '01', '10'; end() },
    'Example 1';

is [special_binary_substrings('000111')],
    bag { item $_ for '000111', '0011', '01'; end() },
    'Example 2';

is [special_binary_substrings('000011')],
    bag { item $_ for '0011', '01'; end() },
    'Example 3';

is [special_binary_substrings('10011100')],
    bag { item $_ for '10', '0011', '01', '1100'; end() },
    'Example 4';

is [special_binary_substrings('00000')], [], 'Example 5';
