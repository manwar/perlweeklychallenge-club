#!/usr/bin/env raku
use v6;

sub popular($paragraph, @banned) {
  my %banned = @banned.Bag;
  $paragraph
    .subst(/<-[a..zA..Z\s]>/," "):global # remove punctuation
    .lc                            # make lowercase
    .split(/\s+/, :skip-empty)     # split on whitespace
    .grep({ %banned{$_}:!exists }) # filter out banned words
    .Bag                           # count remaining words
    .max(*.value)                  # get word with max count
    .keys                          # convert key => val to key
    .first;                        # get the word from the list
}

sub solution($paragraph, @banned) {
  say qq{Input: \$paragraph = "$paragraph"};
  say q{       @banned = (} ~ @banned.map({qq{"$_"}}).join(", ") ~ q{)};
  say qq/Output: "{popular($paragraph, @banned)}"/;
}

say "Example 1:";
solution("Bob hit a ball, the hit BALL flew far after it was hit.", ["hit"]);

say "\nExample 2:";
solution("Apple? apple! Apple, pear, orange, pear, apple, orange.", ["apple", "pear"]);

say "\nExample 3:";
solution("A. a, a! A. B. b. b.", ["b"]);

say "\nExample 4:";
solution("Ball.ball,ball:apple!apple.banana", ["ball"]);

say "\nExample 5:";
solution("The dog chased the cat, but the dog was faster than the cat.", ["the", "dog"]);
