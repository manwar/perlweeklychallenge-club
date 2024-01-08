#!/usr/bin/env perl
use v5.38;

use List::Util qw( max );

sub alphanumValue($str) {
  if ($str =~ /^\d+$/) {
    return $str + 0;
  }
  return length($str);
}

sub maxAlphanumValue(@alphanumstr) {
  my @values = map { alphanumValue($_) } @alphanumstr;
  return max(@values);
}

sub solution(@alphanumstr) {
  say 'Input: @alphanumstr = ("' . join('", "', @alphanumstr) . '")';
  my $maxValue = maxAlphanumValue(@alphanumstr);
  say "Output: $maxValue";
}

say "Example 1:";
solution("perl", "2", "000", "python", "r4ku");

say "\nExample 2:";
solution("001", "1", "000", "0001");