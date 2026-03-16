#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-360#TASK2>

Author: Niels 'PerlBoy' van Dijke

Task 2: Word Sorter
Submitted by: Mohammad Sajid Anwar

You are give a sentence.

Write a script to order words in the given sentence alphabetically but keeps the words themselves unchanged.

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

sub wordSorter ($str) {
  join ' ',sort { fc $a cmp fc $b } grep /\S/, split /\s+/, $str;
}

is(wordSorter('The quick brown fox'),
              'brown fox quick The','Example 1');
is(wordSorter('Hello    World!   How   are you?'),
              'are Hello How World! you?','Example 2');
is(wordSorter('Hello'), 'Hello', 'Example 3');
is(wordSorter('Hello, World! How are you?'),
              'are Hello, How World! you?', 'Example 4');
is(wordSorter('I have 2 apples and 3 bananas!'),
              '2 3 and apples bananas! have I', 'Example 5');
is(wordSorter(' The Weekly Challenge '),
              'Challenge The Weekly','Own example');

done_testing;
