#!/usr/bin/env perl
use strict;
use warnings;

use feature 'say';

use List::Util 1.33 qw/shuffle notall/;

my @dictionary
  = do { open my $fh, '<', 'data/dictionary.txt' or die $!; <$fh>; };
chomp @dictionary;

my %letters_seen;
my @sentence;
for my $word (shuffle @dictionary) {
  my @letters = split //, $word;
  next unless notall { exists $letters_seen{$_} } @letters;
  push @sentence, $word;
  $letters_seen{$_}++ for @letters;
  last if keys %letters_seen == 26;
}

say join ' ', @sentence;
