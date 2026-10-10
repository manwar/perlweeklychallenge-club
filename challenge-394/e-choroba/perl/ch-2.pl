#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub alternating_vowels_consonants(@str) {
    @str = sort { length($a) <=> length($b) } @str;
    for my $length (reverse 2 .. length $str[0]) {
        my @solutions;
        for my $from (0 .. length($str[0]) - $length) {
            my $substr = substr $str[0], $from, $length;
            $substr =~ /^[aeiou]?(?:[^aeiou][aeiou])*[^aeiou]?$/
                or next;

            next if grep -1 == index($_, $substr), @str[1, 2];

            push @solutions, $substr;
        }
        return @solutions if @solutions
    }
    return
}

use Test2::V0;
plan(5);

is [alternating_vowels_consonants('relocate', 'delocate', 'allocate')],
    ['locate'],
    'Example 1';

is [alternating_vowels_consonants('apple', 'banana', 'cherry')],
    [],
    'Example 2';

is [alternating_vowels_consonants('navigate', 'cavity', 'gravity')],
    ['avi'],
    'Example 3';

is [alternating_vowels_consonants('pedalgia', 'pedalboard', 'pedantic')],
    ['peda'],
    'Example 4';

is [alternating_vowels_consonants('schoolmaster', 'schoolhouse', 'schooling')],
    bag { item $_ for 'ho', 'ol'; end() },
    'Example 5';
