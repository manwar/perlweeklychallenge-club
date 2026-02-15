#!/usr/bin/env raku
use v6;

sub wordSorter($str) {
  $str.words.sort: *.fc
}

sub solution($str) {
  say qq/Input: \$str = "$str"/;
  say qq/Output: "{wordSorter($str)}"/;
}

say "Example 1:";
solution("The quick brown fox");

say "\nExample 2:";
solution("Hello    World!   How   are you?");

say "\nExample 3:";
solution("Hello");

say "\nExample 4:";
solution("Hello, World! How are you?");

say "\nExample 5:";
solution("I have 2 apples and 3 bananas!");
