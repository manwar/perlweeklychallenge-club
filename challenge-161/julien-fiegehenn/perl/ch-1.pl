#!/usr/bin/env perl
use strict;
use warnings;

use feature 'say';

my @dictionary
  = do { open my $fh, '<', 'data/dictionary.txt' or die $!; <$fh>; };
chomp @dictionary;

WORD: for my $word (@dictionary) {

  # say $word if join(q{}, sort split //, $word) eq $word; ## this seems like the obvious solution
  my @letters = split //, $word;
  for my $i (0 .. $#letters - 1) {
    next WORD unless ord($letters[$i]) <= ord($letters[$i + 1]);
  }
  say $word;
}
