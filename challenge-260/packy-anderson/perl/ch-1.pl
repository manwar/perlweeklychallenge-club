#!/usr/bin/env perl
use v5.38;

sub uniqueOccurrences(@ints) {
  my %counts;
  foreach my $i ( @ints ) {
    # count how many time each int occurs
    $counts{$i}++;
  }
  my %seen;
  while ( my($i, $c) = each %counts ) {
    # if we've seen this count before, return 0
    return 0 if exists $seen{$c};
    $seen{$c} = $i;
  }
  # each count was unique
  return 1;
}

sub solution(@ints) {
  say 'Input: @ints = (' . join(', ', @ints) . ')';
  say 'Output: ' . uniqueOccurrences(@ints);
}

say "Example 1:";
solution(1,2,2,1,1,3);

say "\nExample 2:";
solution(1,2,3);

say "\nExample 3:";
solution(-2,0,1,-2,1,1,0,1,-2,9);
