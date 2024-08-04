#!/usr/bin/env raku
use v6;

sub countAsterisks($str) {
  (my $excluded = $str) ~~ s:global/\| <-[ | ]> * \|//;
  my %count = $excluded.comb.Bag;
  return 0 unless %count{"*"}:exists;
  return %count{"*"};
}

sub solution($str) {
  say qq/Input: \$str = "$str"/;
  my $count = countAsterisks($str);
  say qq/Output: $count/;
}

say "Example 1:";
solution("p|*e*rl|w**e|*ekly|");

say "\nExample 2:";
solution("perl");

say "\nExample 3:";
solution("th|ewe|e**|k|l***ych|alleng|e");
