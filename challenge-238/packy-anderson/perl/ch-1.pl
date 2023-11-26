#!/usr/bin/env perl
use v5.38;

sub runningSum {
  my @int = @_;
  my @sums;
  my $running_sum = 0;
  foreach my $num ( @int ) {
    # add the next number to the sum of numbers before it
    $running_sum += $num;
    # add the current running sum to the output array
    push @sums, $running_sum;
  }
  return @sums;
}

sub solution {
  my @int = @_;
  say 'Input: @int = (' . join(', ', @int) . ')';
  my @sums = runningSum(@int);
  say 'Output: (' . join(', ', @sums) . ')';
}

say "Example 1:";
solution(1, 2, 3, 4, 5);

say "\nExample 2:";
solution(1, 1, 1, 1, 1);

say "\nExample 3:";
solution(0, -1, 1, 2);