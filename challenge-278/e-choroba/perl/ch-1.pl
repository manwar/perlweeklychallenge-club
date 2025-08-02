#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub sort_string($str) {
    my @words;
    $words[ $2 - 1 ] = $1 while $str =~ /(\S+?)([0-9]+)/g;
    return "@words"
}

use Test::More tests => 3 + 1;

is sort_string('and2 Raku3 cousins5 Perl1 are4'),
    'Perl and Raku are cousins',
    'Example 1';

is sort_string('guest6 Python1 most4 the3 popular5 is2 language7'),
    'Python is the most popular guest language',
    'Example 2';

is sort_string('Challenge3 The1 Weekly2'),
    'The Weekly Challenge',
    'Example 3';

is sort_string(
    'eleven11 ten10 nine9 eight8 seven7 six6 five5 four4 three3 two2 one1'),
    'one two three four five six seven eight nine ten eleven',
    'multiple digits';
