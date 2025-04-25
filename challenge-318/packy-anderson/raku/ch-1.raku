#!/usr/bin/env raku
use v6;

sub groupPosition($str) {
  my @groups;
  while ( $str ~~ m:i:c/ ((<[a..z]>)$0$0+) / ) {
    @groups.push($0);
  }
  if (@groups) {
    return @groups.map({ qq/"$_"/ }).join(", ");
  }
  else {
    return qq/""/;
  }
}

sub solution($str) {
  say qq/Input: \$str = "$str"/;
  my $result = groupPosition($str);
  say qq/Output: $result/;
}

say "Example 1:";
solution("abccccd");

say "\nExample 2:";
solution("aaabcddddeefff");

say "\nExample 3:";
solution("abcdd");
