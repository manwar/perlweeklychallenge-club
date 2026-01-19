#!/usr/bin/env raku
use v6;

sub sort_digits(@digits, $func) {
  @digits.sort($func).join.Int;
}

sub zero_pad(@digits) {
  while (@digits.elems < 4) { @digits.unshift("0"); }
  @digits;
}

sub kaprekarCount($int, $count = 0) {
  # sequence doesn't converge
  return -1 if $int == 0;

  # sequence converged in this many iterations
  return $count if $int == 6174;

  my @digits = zero_pad($int.comb.Array);
  my $num1   = sort_digits(@digits, { $^b cmp $^a });
  my $num2   = sort_digits(@digits, { $^a cmp $^b });
  my $diff   = $num1 - $num2;
  kaprekarCount($diff, $count + 1);
}

sub solution($int) {
  say qq/Input: \$int = $int/;
  say qq/Output: {kaprekarCount($int)}/;
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
