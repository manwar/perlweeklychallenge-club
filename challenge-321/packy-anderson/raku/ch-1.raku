#!/usr/bin/env raku
use v6;

sub distinctAverages(@nums) {
  @nums = @nums.sort;
  my ($explain, $step) = (q{}, 0);
  my %averages = Bag.new;
  while (@nums) {
    my ($min, $max) = (@nums.shift, @nums.pop);
    my $avg = ($min + $max) / 2;
    $step++;
    $explain ~= "Step $step: Min = $min, "
             ~  "Max = $max, Avg = $avg\n";
    %averages{$avg}++;
  }
  $explain ~= "\nThe count of distinct average is "
           ~  %averages.elems ~ ".";
  return %averages.elems, $explain;
}

sub solution(@nums) {
  say 'Input: @nums = (' ~ @nums.join(', ') ~ ')';
  my ($count, $explain) = distinctAverages(@nums);
  say "Output: $count\n\n$explain";
}

say "Example 1:";
solution([1, 2, 4, 3, 5, 6]);

say "\nExample 2:";
solution([0, 2, 4, 8, 3, 5]);

say "\nExample 3:";
solution([7, 3, 1, 0, 5, 9]);

say "\nExample 4:";
solution([1, 9, 2, 6, 3, 4]);