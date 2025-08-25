#!/usr/bin/env perl
use v5.40;

use List::AllUtils qw( reduce );
use Set::Bag;

sub commonCharacters(@words) {
  my @bags = map {
    Set::Bag->new( map { $_ => 1 } split //, $_ )
  } @words;
  my $common = reduce { $a & $b } @bags;
  return sort map { ($_) x $common->grab($_) } $common->elements;
}

sub solution($words) {
  my $list = join ', ', map { qq{"$_"} } @$words;
  say qq/Input: \@words = ($list)/;
  my @common = commonCharacters(@$words);
  $list = join ', ', map { qq{"$_"} } @common;
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
