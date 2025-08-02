#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub word_break($str, @words) {
    my $regex = join '|', map quotemeta, @words;
    return $str =~ /^(?:$regex)+$/
}

use Test2::V0;
plan(3 + 2);

is word_break('weeklychallenge', 'challenge', 'weekly'),
    bool(1),
    'Example 1';
is word_break('perlrakuperl', 'raku', 'perl'),
    bool(1),
    'Example 2';
is word_break('sonsanddaughters', 'sons', 'sand', 'daughters'),
    bool(0),
    'Example 3';

is word_break('abcabcabcabc', 'abc', 'ab', 'bc', 'ca'), bool(1), 'overlap 1';
is word_break('abcdefgh', 'h', 'abcdef', 'abcde', 'abc', 'abcd', 'defg'),
    bool(1),
    'overlap 2';
