#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub find_third($sentence, $first, $second) {
    [$sentence =~ /(?:^| )\Q$first $second\E(?= (\w+))/g]
}

use Test2::V0;
plan(3 + 2);

is find_third('Perl is a my favourite language but Python is my favourite too.',
              'my', 'favourite'),
    ['language', 'too'], 'Example 1';

is find_third('Barbie is a beautiful doll also also a beautiful princess.',
              'a', 'beautiful'),
    ['doll', 'princess'], 'Example 2';

is find_third('we will we will rock you rock you.',,
              'we', 'will'),
    ['we', 'rock'], 'Example 3';

is find_third('Only one of the words is in the sentence',
              'the', 'words'),
    ['is'], '1st word twice, single match on 2nd';
is find_third('Only one of the words is in the sentence or paragraph',
              'the', 'paragraph'),
    [], 'Words not adjacent';
