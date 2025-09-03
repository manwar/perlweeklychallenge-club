#!/usr/bin/env perl
use v5.40;

use List::AllUtils qw( sum );
use List::MoreUtils qw( frequency );

sub smallerThan(@num1) {
  my %bag = frequency @num1;
  my @out;
  foreach my $i ( 0 .. $#num1 ) {
    my %bag2 = %bag{grep { $_ <= $num1[$i] } keys %bag };
    $out[$i] = sum(values %bag2) - 1;
  }
  @out
}

sub solution($num1) {
  say 'Input: @arr = (' . join(', ', @$num1) . ')';
  my @out = smallerThan(@$num1);
  say 'Output: (' . join(', ', @out) . ')';
}

say "Example 1:";
solution([6, 5, 4, 8]);

say "\nExample 2:";
solution([7, 7, 7, 7]);

say "\nExample 3:";
solution([5, 4, 3, 2, 1]);

say "\nExample 4:";
solution([-1, 0, 3, -2, 1]);

say "\nExample 5:";
solution([0, 1, 1, 2, 0]);