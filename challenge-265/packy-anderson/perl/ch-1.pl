#!/usr/bin/env perl
use v5.38;

sub oneThirdAppearance(@ints) {
  my $smallest;
  my $oneThird = @ints / 3;
  my %seen;
  foreach my $i ( @ints ) {
    if (++$seen{$i} >= $oneThird) {
      if (! defined($smallest) || $i < $smallest) {
        $smallest = $i;
      }
    }
  }
  return $smallest;
}

sub solution($ints) {
  say 'Input: @ints = (' . join(', ', @$ints) . ')';
  say 'Output: ' . oneThirdAppearance(@$ints);
}

say "Example 1:";
solution([1,2,3,3,3,3,4,2]);

say "\nExample 2:";
solution([1,1]);

say "\nExample 3:";
solution([1,2,3]);