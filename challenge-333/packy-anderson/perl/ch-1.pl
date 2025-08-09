#!/usr/bin/env perl
use v5.40;

sub straightLine(@list) {
  my $a = shift @list;
  my $b = shift @list;
  my $c = shift @list;
  return (
    ($a->[0] - $b->[0]) * ($b->[1] - $c->[1])
    ==
    ($b->[0] - $c->[0]) * ($a->[1] - $b->[1])
  ) ? 'true' : 'false';
}

sub solution($list) {
  my $str_list = join ', ', map { "[$_->[0], $_->[1]]" } @$list;
  say "Input: \@list = ($str_list)";
  say "Output: " . straightLine(@$list);
}

say "Example 1:";
solution([[2, 1], [2, 3], [2, 5]]);

say "\nExample 2:";
solution([[1, 4], [3, 4], [10, 4]]);

say "\nExample 3:";
solution([[0, 0], [1, 1], [2, 3]]);

say "\nExample 4:";
solution([[1, 1], [1, 1], [1, 1]]);

say "\nExample 5:";
solution([[1000000, 1000000], [2000000, 2000000], [3000000, 3000000]]);
