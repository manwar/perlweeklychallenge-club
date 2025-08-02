#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub find_anagrams(@words) {
    my @sorted = map join("", sort split //), @words;
    my $different = 1;
    for my $i (1 .. $#sorted) {
        ++$different if $sorted[ $i - 1 ] ne $sorted[$i];
    }
    return $different
}

use Test::More tests => 2 + 3;

is find_anagrams('acca', 'dog', 'god', 'perl', 'repl'), 3, 'Example 1';
is find_anagrams('abba', 'baba', 'aabb', 'ab', 'ab'), 2, 'Example 2';

is find_anagrams('ab'), 1, 'Single word';
is find_anagrams('ab', 'cd'), 2, 'No anagrams';
is find_anagrams('ab', 'cd', 'ba'), 3, 'Separated anagrams';
