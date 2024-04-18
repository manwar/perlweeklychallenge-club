#!/usr/bin/env raku
use v6;

sub letterCounts($str) {
  my %counts;
  map { %counts{$_}++ }, (grep { / <lower> / }, $str.lc.comb);
  return %counts;
}

sub completingWord($str, @str) {
  my %target = letterCounts($str);
  my $shortest;
  CANDIDATE: for @str -> $s {
    my %candidate = letterCounts($s);
    for %target.kv -> $c, $i {
      next CANDIDATE # skip this candidate
        unless %candidate{$c}:exists # this letter exists
            && %candidate{$c} >= $i; # at least as many times
    }
    if (! $shortest.defined || $s.chars < $shortest.chars) {
      $shortest = $s;
    }
  }
  return $shortest // q{};
}

sub solution($str, @str) {
  say qq{Input: \$str = '$str'};
  say  q{       @str = ('} ~ @str.join(q{', '}) ~ q{')};
  my $output = completingWord($str, @str);
  say qq{Output: '$output'};
}

say "Example 1:";
solution('aBc 11c', ['accbbb', 'abc', 'abbc']);

say "\nExample 2:";
solution('Da2 abc', ['abcm', 'baacd', 'abaadc']);

say "\nExample 3:";
solution('JB 007', ['jj', 'bb', 'bjb']);