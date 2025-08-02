#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub replace_all_question_marks($str) {
    my $pos = -1;
    while (-1 != ($pos = index $str, '?', $pos)) {
        my $char = 'a';
        ++$char while $char eq substr($str, $pos - 1, 1)
                   || $char eq substr $str, $pos + 1, 1;
        substr $str, $pos, 1, $char;
    }
    return $str
}

use Test::More tests => 3 + 5;

is replace_all_question_marks('a?z'), 'abz', 'Example 1';
is replace_all_question_marks('pe?k'), 'peak', 'Example 2';
is replace_all_question_marks('gra?te'), 'grabte', 'Example 3';

is replace_all_question_marks('a?b'), 'acb', 'Block two';
is replace_all_question_marks('?a'), 'ba', 'Beginning of string';
is replace_all_question_marks('a?'), 'ab', 'End of string';
is replace_all_question_marks('a???b'), 'abacb', 'Chain reaction';
is replace_all_question_marks('??b??'), 'acbab', 'Both ends';
