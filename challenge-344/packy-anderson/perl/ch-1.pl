#!/usr/bin/env perl
use v5.40;

sub compute($ints, $x) {
  split //, join('', @$ints) + $x;
}

sub solution($ints, $x) {
  my $joined = join(', ', @$ints);
  say qq[Input: \@ints = ($joined), \$x = $x];
  $joined = join(', ', compute($ints, $x));
  say qq[Output: ($joined)];
}

say "Example 1:";
solution([1, 2, 3, 4], 12);

say "\nExample 2:";
solution([2, 7, 4], 181);

say "\nExample 3:";
solution([9, 9, 9], 1);

say "\nExample 4:";
solution([1, 0, 0, 0, 0], 9999);

say "\nExample 5:";
solution([0], 1000);
