#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::Util qw{ any uniq };

sub match_string(@words) {
    return uniq(@words[grep {
        my $word = $words[$_];
        any { /\Q$word/ } grep $_ ne $word, @words
    } 0 .. $#words])
}

use Test2::V0;
plan(5 + 4);

# This tests seems to imply the "uniq".
is [match_string(
        'cat', 'cats', 'dog', 'dogcat', 'dogcat', 'rat', 'ratcatdogcat')
    ], ['cat', 'dog', 'dogcat', 'rat'],
    'Example 1';

is [match_string('hello', 'hell', 'world', 'wor', 'ellow', 'elloworld')],
    ['hell', 'world', 'wor', 'ellow'],
    'Example 2';

is [match_string('a', 'aa', 'aaa', 'aaaa')], ['a', 'aa', 'aaa'], 'Example 3';

is [match_string('flower', 'flow', 'flight', 'fl', 'fli', 'ig', 'ght')],
    ['flow', 'fl', 'fli', 'ig', 'ght'],
    'Example 4';

is [match_string('car', 'carpet', 'carpenter', 'pet', 'enter', 'pen', 'pent')],
    ['car', 'pet', 'enter', 'pen', 'pent'],
    'Example 5';

is [match_string()], [], 'No strings';
is [match_string('abc', 'def', 'ghi')], [], 'No matches';
is [match_string("", 'abc')], [""], 'Empty string';
is [match_string('a', 'ab', 'a', 'ac')], ['a'], 'Repeat non-adjacent';
