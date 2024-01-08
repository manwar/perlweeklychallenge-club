#!/usr/bin/env raku
use v6;

sub alphanumValue($str) {
  if ($str ~~ /^\d+$/) {
    return Int($str);
  }
  return $str.chars;
}

sub maxAlphanumValue(@alphanumstr) {
  my @values = @alphanumstr.map({ alphanumValue($_) });
  return @values.max;
}

sub solution(@alphanumstr) {
  say 'Input: @alphanumstr = ("' ~ @alphanumstr.join('", "') ~ '")';
  my $maxValue = maxAlphanumValue(@alphanumstr);
  say "Output: $maxValue";
}

say "Example 1:";
solution(["perl", "2", "000", "python", "r4ku"]);

say "\nExample 2:";
solution(["001", "1", "000", "0001"]);