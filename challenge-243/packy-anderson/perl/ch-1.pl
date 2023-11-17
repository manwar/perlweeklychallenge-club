#!/usr/bin/env perl
use v5.38;

sub isReversePair {
  my ($arr, $i, $j) = @_;
  return $arr->[$i] > 2 * $arr->[$j];
}

sub findReversePairs {
  my @arr = @_;
  my @pairs;
  foreach my $i ( 0 .. $#arr - 1) {
    foreach my $j ( $i+1 .. $#arr) {
      push @pairs, [$i, $j] if isReversePair(\@arr, $i, $j);
    }
  }
  return @pairs;
}

sub solution {
  my @nums = @_;
  say 'Input: @nums = (' . join(', ', @nums) . ')';
  my @pairs = findReversePairs(@nums);
  say 'Output: ' . scalar(@pairs) . "\n";
  for my $pair ( @pairs ) {
    my ($i, $j) = @$pair;
    print "($i, $j) => ";
    print "nums[$i] = $nums[$i], nums[$j] = $nums[$j], ";
    say   "$nums[$i] > 2 * $nums[$j]";
  }
}

say "Example 1:";
solution(1, 3, 2, 3, 1);

say "\nExample 2:";
solution(2, 4, 3, 5, 1);
