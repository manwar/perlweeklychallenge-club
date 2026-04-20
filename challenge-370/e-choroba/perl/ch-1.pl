#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::Util qw{ max };

sub popular_word($paragraph, @banned) {
    my %word;
    ++$word{ lc $1 } while $paragraph =~ /(\w+)/g;
    delete @word{@banned};
    my $max = max(values %word);
    return (grep $max == $word{$_}, keys %word)[0]
}

use Test::More tests => 5;

is popular_word('Bob hit a ball, the hit BALL flew far after it was hit.',
                'hit'),
    'ball', 'Example 1';

is popular_word('Apple? apple! Apple, pear, orange, pear, apple, orange.',
                'apple', 'pear'),
    'orange', 'Example 2';

is popular_word('A. a, a! A. B. b. b.', 'b'), 'a', 'Example 3';

is popular_word('Ball.ball,ball:apple!apple.banana',
                'ball'),
    'apple', 'Example 4';

is popular_word('The dog chased the cat, but the dog was faster than the cat.',
                'the', 'dog'),
    'cat', 'Example 5';
