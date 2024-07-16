#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub reverse_word($word, $char) {
    if ((my $index = 1 + index $word, $char) > 0) {
        substr $word, 0, $index,
            join "", sort split //, substr $word, 0, $index;
    }
    return $word
}

use Test::More tests => 3 + 2;

is reverse_word('challenge', 'e'), 'acehllnge', 'Example 1';
is reverse_word('programming', 'a'), 'agoprrmming', 'Example 2';
is reverse_word('champion', 'b'), 'champion', 'Example 3';

is reverse_word('tome', 't'), 'tome', 'first char';
is reverse_word('tome', 'e'), 'emot', 'last char';
