#!/usr/bin/env raku
use v6;

sub commonCharacters(@words) {
  @words.map({ $_.comb.Bag }).reduce(&infix:<∩>).kxxv.sort;
}

sub solution(@words) {
  my $list = @words.map({ qq{"$_"} }).join(', ');
  say qq/Input: \@words = ($list)/;
  my @common = commonCharacters(@words);
  $list = @common.map({ qq{"$_"} }).join(', ');
  say qq/Output: ($list)/;
}

say "Example 1:";
solution(["bella", "label", "roller"]);

say "\nExample 2:";
solution(["cool", "lock", "cook"]);

say "\nExample 3:";
solution(["hello", "world", "pole"]);

say "\nExample 4:";
solution(["abc", "def", "ghi"]);

say "\nExample 5:";
solution(["aab", "aac", "aaa"]);
