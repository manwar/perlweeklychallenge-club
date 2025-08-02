#!/usr/bin/env perl
use v5.40;

sub goodInteger($int) {
  my @chars = split //, "$int";
  my $good  = shift @chars;
  my $count = 1;
  foreach my $c ( @chars ) {
    if ($c ne $good) {
      # the character changed!
      if ($count == 3) {
        last;
      }
      # restart the count with new character
      $good  = $c;
      $count = 1;
    }
    else {
      # the character is the same
      $count++;
    }
  }
  if ($count == 3) {
    return '"' . ($good x $count) . '"';
  }
  return -1;
}

sub solution($int) {
  say qq/Input: \$int = $int/;
  say qq/Output: / . goodInteger($int);
}

say "Example 1:";
solution(12344456);

say "\nExample 2:";
solution(1233334);

say "\nExample 3:";
solution(10020003);

