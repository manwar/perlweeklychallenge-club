#!/usr/bin/env perl
use v5.40;


sub divmod($x, $y) { (int($x / $y), $x % $y) }

sub list_div($list, $n) {
  return -1 if @$list < $n;
  my ($c, $r) = divmod(scalar(@$list), $n);
  my @result;
  while (@$list) {
    my @a;
    push @a, shift(@$list) for 1..$c;
    push @a, shift(@$list) if --$r >= 0;
    push @result, \@a;
  }
  @result;
}

sub int_join($list) { "(" . join(",", @$list) . ")" }

sub solution($list, $n) {
  say 'Input: @list = (' . join(', ', @$list) . '), $n = ' . $n;
  my @result = list_div($list, $n);
  my $joined = @result == 1 && $result[0] == -1
          ? "-1"
          : "(" . join(", ", map { int_join($_) } @result) . ")";
  say 'Output: ' . $joined;
}

say "Example 1:";
solution([1,2,3,4,5], 2);

say "\nExample 2:";
solution([1,2,3,4,5,6], 3);

say "\nExample 3:";
solution([1,2,3], 2);

say "\nExample 4:";
solution([1,2,3,4,5,6,7,8,9,10], 5);

say "\nExample 5:";
solution([1,2,3], 4);

say "\nExample 6:";
solution([72,57,89,55,36,84,10,95,99,35], 7);