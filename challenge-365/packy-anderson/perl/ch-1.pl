#!/usr/bin/env perl
use v5.40;
use List::AllUtils qw( sum );

sub alphaIndexDigitSum($str, $k) {
  my $numstr = join '', map { ord($_) - 96 } split //, $str;
  $numstr = sum(split //, $numstr) while ($k-- > 0);
  return $numstr;
}

sub solution($str, $k) {
  say qq/Input: \$str = "$str", \$k = $k/;
  say qq/Output: @{[alphaIndexDigitSum($str, $k)]}/;
}

say "Example 1:";
solution("abc", 1);

say "\nExample 2:";
solution("az", 2);

say "\nExample 3:";
solution("cat", 1);

say "\nExample 4:";
solution("dog", 2);

say "\nExample 5:";
solution("perl", 3);

say "\nExample BigBird:";
solution("abcdefghijklmnopqrstuvwxyz", 1);

