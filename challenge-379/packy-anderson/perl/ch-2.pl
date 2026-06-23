#!/usr/bin/env perl
use v5.40;

use List::AllUtils qw( sum );
sub digits($base, $num) {
  return (0) if $num == 0; # base case
  my @digits;
  while ($num  > 0) {
    unshift @digits, ($num % $base);
    $num = int($num / $base);
  }
  @digits;
}

sub armstrong($base, $limit) {
  my $n = 0;
  my @armstrong;
  while ($n <= $limit) {
    my @dig = digits($base, $n);
    my $pow = @dig;
    my $n2  = sum map { $_ ** $pow } @dig;
    push @armstrong, $n if $n == $n2;
    $n++;
  }
  @armstrong
}

sub solution($base, $limit) {
  say qq/Input: \$base = $base, \$limit = $limit/;
  say 'Output: (' . join(', ', armstrong($base, $limit)) . ')';
}

say "Example 1:";
solution(10, 1000);

say "\nExample 2:";
solution(7, 1000);

say "\nExample 3:";
solution(16, 1000);
