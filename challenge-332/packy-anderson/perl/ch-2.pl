#!/usr/bin/env perl
use v5.40;

sub oddLetters($str) {
  my %letters;
  map { $letters{$_}++ } split //, $str;
  foreach my $times (values %letters) {
    return 'false' if $times % 2 == 0;
  }
  return 'true';
}

sub solution($str) {
  say qq/Input: \$str = "$str"/;
  say qq/Output: @{[oddLetters($str)]}/;
}

say "Example 1:";
solution("weekly");

say "\nExample 2:";
solution("perl");

say "\nExample 3:";
solution("challenge");
