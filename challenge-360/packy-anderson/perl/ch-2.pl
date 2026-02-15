#!/usr/bin/env perl
use v5.40;

sub wordSorter($str) {
  sort { fc($a) cmp fc($b) } split " ", $str;
}

sub solution($str) {
  say qq/Input: \$str = "$str"/;
  say qq/Output: "@{[wordSorter($str)]}"/;
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

