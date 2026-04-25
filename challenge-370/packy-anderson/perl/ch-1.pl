#!/usr/bin/env perl
use v5.40;

use List::MoreUtils qw( frequency );
use List::UtilsBy   qw( max_by );

sub popular($paragraph, @banned) {
  my %banned = map { $_ => 1 } @banned;

  $paragraph =~ s/[^a-zA-Z\s]/ /g; # remove punctuation
  my %popular = frequency          # count words after
    grep { !exists $banned{$_}}    # filter out banned words after
    split(" ",                     # split on whitespace after
      lc($paragraph)               # make lowercase
    );

  max_by { $popular{$_} } keys %popular; # get word with max count
}

sub solution($paragraph, $banned) {
  say qq{Input: \$paragraph = "$paragraph"};
  say q{       @banned = (} . join(", ", map {qq{"$_"}} @$banned) . q{)};
  say qq/Output: "@{[popular($paragraph, @$banned)]}"/;
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
