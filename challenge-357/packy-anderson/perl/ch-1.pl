#!/usr/bin/env perl
use v5.40;

sub sort_digits($digits, $func) {
  join('', sort { $func->() } @$digits);
}

sub zero_pad(@digits) {
  while (@digits < 4) { unshift @digits, "0"; }
  @digits;
}

sub kaprekarCount($int, $count = 0) {
  # sequence doesn't converge
  return -1 if $int == 0;

  # sequence converged in this many iterations
  return $count if $int == 6174;

  my @digits = zero_pad(split //, $int);
  my $num1   = sort_digits(\@digits, sub { $b <=> $a });
  my $num2   = sort_digits(\@digits, sub { $a <=> $b });
  my $diff   = $num1 - $num2;
  kaprekarCount($diff, $count + 1);
}

sub solution($int) {
  say qq/Input: \$int = $int/;
  say qq/Output: @{[kaprekarCount($int)]}/;
}

say "Example 1:";
solution(3524);

say "\nExample 2:";
solution(6174);

say "\nExample 3:";
solution(9998);

say "\nExample 4:";
solution(1001);

say "\nExample 5:";
solution(9000);

say "\nExample 6:";
solution(1111);
