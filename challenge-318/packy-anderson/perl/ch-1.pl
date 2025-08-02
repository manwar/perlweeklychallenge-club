#!/usr/bin/env perl
use v5.40;

sub groupPosition($str) {
  my @groups;
  while ( $str =~ /([a-z])\1\1+/gip ) {
    push @groups, ${^MATCH};
  }
  if (@groups) {
    return join(", ", map { qq/"$_"/ } @groups);
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
