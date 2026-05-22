#!/usr/bin/env perl
use v5.40;

use List::AllUtils qw( max );

sub maxSame($str) {
  my @digits  = split //, $str;
  my $current = shift @digits;
  my $largest = $current + 0;
  for my $digit (@digits) {
    $current = substr($current,0,1) eq $digit ? $current . $digit
             :                                  $digit;
    $largest = max($current + 0, $largest);
  }
  $largest;
}

sub solution($str) {
  say qq/Input: \$str = "$str"/;
  say 'Output: ' . maxSame($str);
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
