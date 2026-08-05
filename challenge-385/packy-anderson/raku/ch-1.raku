#!/usr/bin/env raku
use v6;

sub uncommonWords($sentence1, $sentence2) {
  ($sentence1 ~ " " ~ $sentence2) # make two sentences one
  .split(/\s+/)            # split on whitespace
  .Bag                     # count occurrences of each word
  .grep({ $_.value == 1 }) # filter for words that happen once
  .Bag                     # .grep returns a Seq, make it a Bag
  .keys                    # return just the keys
  .sort;             # but sort so the answer's always the same
}

sub solution($sentence1, $sentence2) {
  say qq/Input: \$sentence1 = "$sentence1"/;
  say qq/       \$sentence2 = "$sentence2"/;
  say 'Output: (' ~ uncommonWords($sentence1, $sentence2).map({qq/"$_"/}).join(', ') ~ ')';
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
