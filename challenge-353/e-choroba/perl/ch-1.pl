#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::Util qw{ max };

sub max_words(@sentences) {
    return max(map scalar(split), @sentences)
}

use Test::More tests => 5 + 1;

is max_words('Hello world', 'This is a test', 'Perl is great'), 4, 'Example 1';
is max_words('Single'), 1, 'Example 2';
is max_words('Short',
             'This sentence has seven words in total',
             'A B C',
             'Just four words here'
), 7, 'Example 3';

is max_words('One', 'Two parts', 'Three part phrase', ''), 3, 'Example 4';
is max_words('The quick brown fox jumps over the lazy dog',
             'A',
             'She sells seashells by the seashore',
             'To be or not to be that is the question'
), 10, 'Example 5';
is max_words("", ""), 0, 'Empty';
