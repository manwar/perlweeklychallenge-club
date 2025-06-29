#!/usr/bin/env perl
use v5.40;

use List::AllUtils qw( max );

sub MAD(@ints) {
  my @mad;
  # let's make the biggest int our starting minimum
  my $min = max @ints;
  while (my $x = shift @ints) {
    foreach my $y ( @ints ) {
      my $diff = abs($x - $y);
      next if $diff > $min; # too big!
      if ($diff < $min) { # we found a new min!
        $min = $diff; # set the new minimum
        @mad = ();    # clear the old list
      }
      # make sure we put the numbers on the list
      # with the smaller integer first
      push @mad, [sort $x, $y];
    }
  }
  # and return the list with the pairs sorted as well
  return sort { $a->[0] <=> $b->[0] } @mad;
}

sub solution($ints) {
  say 'Input: @ints = (' . join(', ', @$ints) . ')';
  my @mad = MAD(@$ints);
  # make them printable
  @mad = map { qq{[$_->[0],$_->[1]]} } @mad;
  say 'Output: ' . join(', ', @mad);
}

say "Example 1:";
solution([4, 1, 2, 3]);

say "\nExample 2:";
solution([1, 3, 7, 11, 15]);

say "\nExample 3:";
solution([1, 5, 3, 8]);
