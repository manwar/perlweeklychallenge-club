#!/usr/bin/env perl

use v5.38;
use Test::More;

sub typable_word_count($str, $keys) {
    my @words = split /\s+/, $str;
    return scalar @words unless @$keys;

    my $broken_chars = quotemeta(join '', @$keys);
    return scalar grep { !/[$broken_chars]/i } @words;
}

my $examples = [
    { str => 'Hello World',          keys => ['d'],      exp => 1 },
    { str => 'apple banana cherry',  keys => ['a', 'e'], exp => 0 },
    { str => 'Coding is fun',        keys => [],         exp => 3 },
    { str => 'The Weekly Challenge', keys => ['a','b'],  exp => 2 },
    { str => 'Perl and Python',      keys => ['p'],      exp => 1 },
];

is(typable_word_count($_->{str}, $_->{keys}), $_->{exp}) for @$examples;

done_testing;
