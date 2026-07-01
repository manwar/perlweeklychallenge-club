#!/usr/bin/env raku
use v6;

sub sumFrequencies($str) {
  my $max_vowel     = $str.comb(/ <[aeiou]>/).Bag.values.max;
  my $max_consonant = $str.comb(/<-[aeiou]>/).Bag.values.max;
  # if a list is empty, the max is -Inf
  return max($max_vowel, 0) + max($max_consonant, 0);
}

sub solution($str) {
  say 'Input: $str = "' ~ $str ~ '"';
  say 'Output: ' ~ sumFrequencies($str);
}

say "Example 1:";
solution("banana");

say "\nExample 2:";
solution("teestett");

say "\nExample 3:";
solution("aeiouuaa");

say "\nExample 4:";
solution("rhythm");

say "\nExample 5:";
solution("x");
