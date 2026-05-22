#!/usr/bin/env raku
use v6;

sub maxSame($str) {
  my @digits  = $str.comb;
  my $current = @digits.shift;
  my $largest = $current.Int;
  for @digits -> $digit {
    $current = $current.starts-with($digit) ??  $current ~ $digit
            !!                                  $digit;
    $largest = [$current.Int, $largest].max;
  }
  $largest;
}

sub solution($str) {
  say qq/Input: \$str = "$str"/;
  say 'Output: ' ~ maxSame($str);
}

say "Example 1:";
solution("6777133339");

say "\nExample 2:";
solution("1200034");

say "\nExample 3:";
solution("44221155");

say "\nExample 4:";
solution("88888");

say "\nExample 5:";
solution("11122233");
