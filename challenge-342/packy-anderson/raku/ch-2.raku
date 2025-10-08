#!/usr/bin/env raku
use v6;

multi max_score($str, $split where $split >= $str.chars, $count,
                $max, $explain) {
  # there's no more to split!
  return ($max, $explain);
}

multi max_score($str, $split, $count,
                $max is copy, $explain is copy) {
  my $left  = $str.substr(0, $split);
  my $right = $str.substr($split);
  my $zeros = $left.comb(/0/).elems;
  my $ones  = $right.comb(/1/).elems;
  my $sum   = $zeros + $ones;
  $explain ~= qq{\n$count: left = "$left", right = "$right"}
           ~  qq{ => $zeros + $ones => $sum};
  $max = max($max, $sum);
  return max_score($str, $split+1, $count+1, $max, $explain);
}

multi max_score($str) {
  max_score($str, 1, 1, 0, "");
}

sub solution($str) {
  say 'Input: $str = "' ~ $str ~ '"';
  my ($max, $explain) = max_score($str);
  say 'Output: ' ~ $max;
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
