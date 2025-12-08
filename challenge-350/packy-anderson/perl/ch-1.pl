#!/usr/bin/env perl
use v5.40;

use List::MoreUtils qw( any frequency );

sub goodString($str) {
  my $good = 0;
  foreach my $i (0 .. length($str) - 3) {
    my $substr = substr($str, $i, $i+2);
    my %bag = frequency split //, $substr;
    $good++ unless any { $_ > 1 } values %bag;
  }
  return $good;
}

sub solution($str) {
  say 'Input: $str = "' . $str . '"';
  say 'Output: ' . goodString($str);
}

say "Example 1:";
solution("abcaefg");

say "\nExample 2:";
solution("xyzzabc");

say "\nExample 3:";
solution("aababc");

say "\nExample 4:";
solution("qwerty");

say "\nExample 5:";
solution("zzzaaa");
