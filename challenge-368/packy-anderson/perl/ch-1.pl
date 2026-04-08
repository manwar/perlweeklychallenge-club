#!/usr/bin/env perl
use v5.40;

use List::AllUtils qw( max );

sub bigger($str, $char) {
  my $i = 0;
  my @indices;
  while (($i = index($str, $char, $i)) >= 0) {
    push @indices, $i++;
  }
  return $str unless @indices; # doesn't occur
  my @possible;
  foreach $i ( @indices ) {
    substr((my $tmp = $str), $i, 1) = "";
    push @possible, $tmp;
  }
  return max @possible;
}

sub solution($str, $char) {
  say qq/Input: \$str = "$str", \$char = "$char"/;
  say qq/Output: "@{[bigger($str, $char)]}"/;
}

say "Example 1:";
solution("15456", "5");

say "\nExample 2:";
solution("7332", "3");

say "\nExample 3:";
solution("2231", "2");

say "\nExample 4:";
solution("543251", "5");

say "\nExample 5:";
solution("1921", "1");

say "\nExample trivial 1:";
solution("12345", "6");

say "\nExample trivial 2:";
solution("12345", "1");