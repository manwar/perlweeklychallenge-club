#!/usr/bin/env perl
use v5.40;

sub missingInts(@ints) {
  my %set = map { $_ => 1} @ints;
  my @missing;
  foreach my $i ( 1 .. scalar(@ints) ) {
    push @missing, $i unless exists $set{$i};
  }
  return @missing;
}

sub solution($ints) {
  say 'Input: @ints = (' . join(', ', @$ints) . ')';
  my @missing = missingInts(@$ints);
  say 'Output: (' . join(', ', @missing) . ')';
}

say "Example 1:";
solution([1, 2, 1, 3, 2, 5]);

say "\nExample 2:";
solution([1, 1, 1]);

say "\nExample 3:";
solution([2, 2, 1]);
