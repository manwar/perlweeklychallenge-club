#!/usr/bin/env raku
use v6;

sub properSubsets(@array, $min) {
  return @array.combinations: $min .. @array.elems -1;
}

sub equilibrium(@nums) {
  my $i = 1; # start with index 1
  my @tuples = @nums.map({ [ $i++, $_ ] });
  my (@results, @explain, $count);
  # loop over the subsets with 2 or more elements
  for properSubsets(@tuples, 2) -> @s {
    my @indices = @s.map({ $_[0] });
    my @values  = @s.map({ $_[1] });
    next unless @indices.sum == @values.sum;
    $count++;
    my $explanation
      = "Subset $count: ({ @values.join(', ') })\n"
      ~ "Values: { @values.join(' + ') } = { @values.sum }\n"
      ~ "Positions: { @indices.join(' + ') } = { @indices.sum }";
    @explain.push: $explanation;
    @results.push: @values;
  }
  return @explain.join("\n\n"), [@results];
}

sub displaySubsets(@subsets is copy) {
  return '()' unless @subsets; # special case
  @subsets.map({ '(' ~ $_.join(', ') ~ ')' }).join(', ');
}

sub solution(@nums) {
  say 'Input: @nums = (' ~ @nums.join(', ') ~ ')';
  my ($explain, $results) = equilibrium(@nums);
  say 'Output: ' ~ displaySubsets(@$results);
  say "\n" ~ $explain if $explain;
}

say "Example 1:";
solution([2, 1, 4, 3]);

say "\nExample 2:";
solution([3, 0, 3, 0]);

say "\nExample 3:";
solution([5, 1, 1, 1]);

say "\nExample 4:";
solution([3, -1, 4, 2]);

say "\nExample 5:";
solution([10, 20, 30, 40]);
