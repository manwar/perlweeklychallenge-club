#!/usr/bin/env raku
use v6;

sub digits($base, $num is copy) {
  return [0] if $num == 0; # base case
  my @digits;
  while ($num  > 0) {
    @digits.unshift($num % $base);
    $num = $num div $base;
  }
  @digits;
}

sub armstrong($base, $limit) {
  my $n = 0;
  my @armstrong;
  while ($n <= $limit) {
    my @dig = digits($base, $n);
    my $pow = @dig.elems;
    my $n2  = @dig.map({ $_ ** $pow }).sum;
    @armstrong.push($n) if $n == $n2;
    $n++;
  }
  @armstrong
}

sub solution($base, $limit) {
  say qq/Input: \$base = $base, \$limit = $limit/;
  say 'Output: (' ~ armstrong($base, $limit).join(', ') ~ ')';
}

say "Example 1:";
solution(10, 1000);

say "\nExample 2:";
solution(7, 1000);

say "\nExample 3:";
solution(16, 1000);
