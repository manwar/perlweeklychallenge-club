#!/usr/bin/env raku
use v6;

# map chars => values like 'A' => 10, 'a' => 37
my %chars = (0...9,'A'...'Z','a'...'z','+','/').antipairs.Hash;

sub reverseBase($num, $base) {
  $num.Str.comb        # break the number into digits
  .map({ %chars{$_} }) # map character to numeric equivalent
  .reverse             # reverese the string so place -> power
  .pairs               # make a seq of pairs with position as key
  .map({ ($base ** $_.key) * $_.value }) # multiply by power
  .sum                 # add it all up
}

sub solution($num, $base) {
  say qq/Input: \$num = "$num", \$base = $base/;
  say qq/Output: {reverseBase($num, $base)}/;
}

say "Example 1:";
solution("101010", 2);

say "\nExample 2:";
solution("EEADEE", 16);

say "\nExample 3:";
solution("755", 8);

say "\nExample 4:";
solution("1BRJB", 36);

say "\nExample 5:";
solution("7MyqL", 64);
