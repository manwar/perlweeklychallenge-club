#!/usr/bin/env perl

# Write a program which prints out all anagrams for a given word. For more
# information about Anagram, please check this:
# https://en.wikipedia.org/wiki/Anagram

use 5.026;
use strict;
use autodie;
use warnings;

my $word = shift or die "usage: $0 WORD [WORDFILE...]\n";

my $key = join('', sort split //, lc $word);

say foreach grep { chomp; $key eq join('', sort split //, lc $_) } <>;
