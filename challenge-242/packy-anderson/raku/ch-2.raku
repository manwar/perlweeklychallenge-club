#!/usr/bin/env raku
use v6;

sub flipMatrix(@matrix) {
  for @matrix -> @subarray {
    @subarray = @subarray.reverse.map: (* - 1).abs;
  }
  return @matrix;
}

sub formatArray(@matrix) {
  my @formatted;
  for @matrix -> @subarray {
    @formatted.push('[' ~ @subarray.join(', ') ~ ']');
  }
  return '(' ~ @formatted.join(', ') ~ ')';
}

sub solution(**@matrix) {
  say 'Input: @matrix = ' ~ formatArray(@matrix);
  my @output = flipMatrix(@matrix);
  say 'Output: ' ~ formatArray(@output);
}

say "Example 1:";
solution([1, 1, 0], [1, 0, 1], [0, 0, 0]);

say "\nExample 2:";
solution([1, 1, 0, 0], [1, 0, 0, 1], [0, 1, 1, 1], [1, 0, 1, 0]);