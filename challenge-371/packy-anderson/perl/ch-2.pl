#!/usr/bin/env perl
use v5.40;

use Algorithm::Combinatorics qw( subsets );
use List::AllUtils qw( sum );

sub equilibrium(@nums) {
  my $i = 1; # start with index 1
  my @tuples = map { [ $i++, $_ ] } @nums;
  my (@results, @explain, $count);
  # loop over the subsets
  foreach my $s (subsets(\@tuples)) {
    # only consider PROPER subsets with 2 or more elements
    next unless @$s > 1 && @$s < @tuples;
    my @indices = map { $_->[0] } @$s;
    my @values  = map { $_->[1] } @$s;
    next unless sum(@indices) == sum(@values);
    $count++;
    my $plus_values  = join(' + ', @values);
    my $plus_indices = join(' + ', @indices);
    my $explanation
      = "Subset $count: (@{[ join(', ', @values) ]})\n"
      . "Values: $plus_values = @{[ sum(@values) ]}\n"
      . "Positions: $plus_indices = @{[ sum(@indices) ]}";
    push @explain, $explanation;
    push @results, \@values;
  }
  return join("\n\n", @explain), [@results];
}

sub displaySubsets(@subsets) {
  return '()' unless @subsets; # special case
  join ', ', map { '(' . join(', ', @$_) . ')' } @subsets;
}

sub solution($nums) {
  say 'Input: @nums = (' . join(', ', @$nums) . ')';
  my ($explain, $results) = equilibrium(@$nums);
  say 'Output: ' . displaySubsets(@$results);
  say "\n" . $explain if $explain;
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
