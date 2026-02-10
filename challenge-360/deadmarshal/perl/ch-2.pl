#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(fc);

sub word_sorter{
  join ' ',sort {fc($a) cmp fc($b)} split /\s+/,$_[0];
}

printf "%s\n",word_sorter('The quick brown fox');
printf "%s\n",word_sorter('Hello    World!   How   are you?');
printf "%s\n",word_sorter('Hello');
printf "%s\n",word_sorter('Hello, World! How are you?');
printf "%s\n",word_sorter('I have 2 apples and 3 bananas!');

