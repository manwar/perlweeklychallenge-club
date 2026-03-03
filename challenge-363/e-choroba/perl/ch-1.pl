#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use Lingua::EN::Numbers qw{ num2en };

sub string_lie_detector($str) {
    my ($word, $v, $c) = $str =~ /^(\w*) - (\w+) vowels? and (\w+) consonants?$/
        or die "Can't parse input '$str'.";
    my $vowels = $word =~ tr/aeiou//;
    my $consonants = length($word) - $vowels;
    return num2en($vowels) eq $v && num2en($consonants) eq $c
}

use Test2::V0;
use constant {true => bool(1), false => bool(0)};

plan(5 + 1);

is string_lie_detector('aa - two vowels and zero consonants'),
    true, 'Example 1';
is string_lie_detector('iv - one vowel and one consonant'),
    true, 'Example 2';
is string_lie_detector('hello - three vowels and two consonants'),
    false, 'Example 3';
is string_lie_detector('aeiou - five vowels and zero consonants'),
    true, 'Example 4';
is string_lie_detector('aei - three vowels and zero consonants'),
    true, 'Example 5';

is string_lie_detector(' - zero vowels and zero consonants'),
    true, 'Empty string';
