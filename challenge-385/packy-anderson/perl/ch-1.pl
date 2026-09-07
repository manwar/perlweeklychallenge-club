#!/usr/bin/env perl
use v5.44;

use List::MoreUtils qw( frequency );

sub uncommonWords($sentence1, $sentence2) {
  my %bag = frequency    # count occurrences of each word
  split /\s+/,           # split on whitespace
  $sentence1 . " " . $sentence2; # make two sentences one
  sort                   # sort so the answer's always the same
  grep { $bag{$_} == 1 } # filter for words that happen once
  keys %bag;             # return just the keys          
}

sub solution($sentence1, $sentence2) {
  say qq/Input: \$sentence1 = "$sentence1"/;
  say qq/       \$sentence2 = "$sentence2"/;
  say 'Output: (' . join(', ', map { qq/"$_"/ } uncommonWords($sentence1, $sentence2)) . ')';
}

say "Example 1:";
solution("apple banana apple", "banana orange");

say "\nExample 2:";
solution("cat dog", "bird fish");

say "\nExample 3:";
solution("the quick brown fox", "the quick");

say "\nExample 4:";
solution("hello", "hello");

say "\nExample 5:";
solution("blue blue red", "red green green yellow");
