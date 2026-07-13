#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub replace_question_mark($str) {
    [$str =~ /\?/
           ? (map @{ replace_question_mark($str =~ s/\?/$_/r) }, 0, 1)
           : $str]
}

use Test2::V0;
plan(5);

is replace_question_mark('01??0'), ['01000', '01010', '01100', '01110'],
    'Example 1';
is replace_question_mark('101'), ['101'], 'Example 2';
is replace_question_mark('???'), ['000', '001', '010', '011', '100', '101',
                                  '110', '111'],
    'Example 3';
is replace_question_mark('1?10'), ['1010', '1110'], 'Example 4';
is replace_question_mark('1?1?0'), ['10100', '10110', '11100', '11110'],
    'Example 5';
