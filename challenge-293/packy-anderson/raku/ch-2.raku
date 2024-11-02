#!/usr/bin/env raku
use v6;

sub isBoomerang(@points) {
  # check that we have three distinct points
  my %distinct;
  for @points -> @p {
    %distinct{@p.join(",")}++;
  }
  return 'false' if %distinct.keys.elems < 3;

  # is this a straight line on the X axis?
  return 'false'
    if @points[0][0] == @points[1][0] == @points[2][0];

  # is this a straight line on the Y axis?
  return 'false'
    if @points[0][1] == @points[1][1] == @points[2][1];

  # find the differences between the X coordinates
  my $x_diff_1 = @points[1][0] - @points[0][0];
  my $x_diff_2 = @points[2][0] - @points[1][0];

  # find the differences between the Y coordinates
  my $y_diff_1 = @points[1][1] - @points[0][1];
  my $y_diff_2 = @points[2][1] - @points[1][1];

  # straight line if the diffs are the same
  return 'false'
    if $x_diff_1 == $x_diff_2 && $y_diff_1 == $y_diff_2;

  return 'true';
}

sub solution(@points) {
  my @p = @points.map({ '[' ~ .join(', ') ~ ']' });
  say 'Input: @points = (' ~ @p.join(', ') ~ ')';
  say 'Output: ' ~ isBoomerang(@points);
}

say "Example 1:";
solution([[1, 1], [2, 3], [3,2]]);

say "\nExample 2:";
solution([[1, 1], [2, 2], [3, 3]]);

say "\nExample 3:";
solution([[1, 1], [1, 2], [2, 3]]);

say "\nExample 4:";
solution([[1, 1], [1, 2], [1, 3]]);

say "\nExample 5:";
solution([[1, 1], [2, 1], [3, 1]]);

say "\nExample 6:";
solution([[0, 0], [2, 3], [4, 5]]);