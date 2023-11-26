#!/usr/bin/env raku
use v6;

sub runningSum(*@int) {
  my @sums;
  my $running_sum = 0;
  for @int -> $num {
    # add the next number to the sum of numbers before it
    $running_sum += $num;
    # add the current running sum to the output array
    @sums.push( $running_sum );
  }
  return @sums;
}

sub solution {
  my @int = @_;
  say 'Input: @int = (' ~ @int.join(', ') ~ ')';
  my @sums = runningSum(@int);
  say 'Output: (' ~ @sums.join(', ') ~ ')';
}

say "Example 1:";
solution(1, 2, 3, 4, 5);

say "\nExample 2:";
solution(1, 1, 1, 1, 1);

say "\nExample 3:";
solution(0, -1, 1, 2);