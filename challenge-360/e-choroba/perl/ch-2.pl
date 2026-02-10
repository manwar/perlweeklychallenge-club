#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub word_sorter($str) {
    return join ' ', map $_->[0],
                     sort { $a->[1] cmp $b->[1] }
                     map [$_, lc $_],
                     split /\s+/, $str
}

use Test::More tests => 5;


is word_sorter('The quick brown fox'), 'brown fox quick The', 'Example 1';
is word_sorter('Hello    World!   How   are you?'), 'are Hello How World! you?',
    'Example 2';
is word_sorter('Hello'), 'Hello', 'Example 3';
is word_sorter('Hello, World! How are you?'), 'are Hello, How World! you?',
    'Example 4';
is word_sorter('I have 2 apples and 3 bananas!'),
    '2 3 and apples bananas! have I',
    'Example 5';
