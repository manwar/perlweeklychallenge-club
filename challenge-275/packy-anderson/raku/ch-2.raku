#!/usr/bin/env raku
use v6;

sub replaceDigits($str) {
  my @chars = $str.comb;
  my $last_letter = @chars[0];
  my $out;
  for @chars -> $c {
    if ($c ~~ /<[0..9]>/) {
      $out ~= ( $last_letter.ord + $c.Int ).chr;
    }
    else {
      $out ~= $c;
      $last_letter = $c;
    }
  }
  return $out;
}

sub solution($str) {
  say "Input: \$str = '$str'";
  say 'Output: \'' ~ replaceDigits($str) ~ '\'';
}

say "Example 1:";
solution("a1c1e1");

say "\nExample 2:";
solution("a1b2c3d4");

say "\nExample 3:";
solution("b2b");

say "\nExample 4:";
solution("a16z");
