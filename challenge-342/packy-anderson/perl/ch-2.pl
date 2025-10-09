#!/usr/bin/env perl
use v5.40;

use List::AllUtils qw( max );

sub max_score2($str, $split, $count,
                $max, $explain) {
  my $left  = substr($str, 0, $split);
  my $right = substr($str, $split);
  my $zeros = scalar(grep { /0/ } split //, $left);
  my $ones  = scalar(grep { /1/ } split //, $right);
  my $sum   = $zeros + $ones;
  $explain .= qq{\n$count: left = "$left", right = "$right"}
           .  qq{ => $zeros + $ones => $sum};
  $max = max($max, $sum);
  if (length($right) == 1) {
    # there's no more to split!
    return ($max, $explain);
  }
  return max_score2($str, $split+1, $count+1, $max, $explain);
}

sub max_score($str) {
  max_score2($str, 1, 1, 0, "");
}

sub solution($str) {
  say 'Input: $str = "' . $str . '"';
  my ($max, $explain) = max_score($str);
  say 'Output: ' . $max;
  say "$explain\n";
}

say "Example 1:";
solution("0011");

say "\nExample 2:";
solution("0000");

say "\nExample 3:";
solution("1111");

say "\nExample 4:";
solution("0101");

say "\nExample 5:";
solution("011101");
