#!/usr/bin/env perl
use v5.38;

sub mergeItems($items1, $items2) {
  my %merged;
  # loop over the items and add item_quantities (element 1)
  # to the count for each item_id (element 0)
  foreach my $i (@$items1, @$items2) {
    $merged{$i->[0]} += $i->[1];
  }
  # re-render the hash as a 2D array
  return [ map { [ $_, $merged{$_} ] } sort keys %merged ];
}

sub string2D($array) {
  my @output;
  foreach my $i (@$array) {
    push @output, '[' . join(',', @$i) . ']';
  }
  return '[ ' . join(', ', @output) . ' ]';
}

sub solution($items1, $items2) {
  say 'Input: $items1 = ' . string2D($items1);
  say '       $items2 = ' . string2D($items2);
  my $merged = mergeItems($items1, $items2);
  say 'Output: ' . string2D($merged);
}

say "Example 1:";
solution(
  [ [1,1], [2,1], [3,2] ],
  [ [2,2], [1,3] ]
);

say "\nExample 2:";
solution(
  [ [1,2], [2,3], [1,3], [3,2] ],
  [ [3,1], [1,3] ]
);

say "\nExample 3:";
solution(
  [ [1,1], [2,2], [3,3] ],
  [ [2,3], [2,4] ]
);