#!/usr/bin/env perl
use v5.38;

use Algorithm::Combinatorics qw( combinations );

sub largestOfThree {
  my @ints = @_;
  my $max = -1; # initialize our failure case
  my @combos = map {
    combinations(\@ints, $_)
  } 1 .. scalar(@ints);
  foreach my $combo ( @combos ) {
    # sort the digits in descending order,
    # join them, then convert to an Int
    my $num = join('', reverse sort @$combo) + 0;
    next unless $num > $max;   # not bigger than current max
    next unless $num % 3 == 0; # not divisible by 3
    $max = $num;
  }
  return $max;
}

sub solution {
  my @ints = @{ shift @_ };
  say 'Input: @ints = (' . join(', ', @ints) . ')';
  my $output = largestOfThree(@ints);
  say 'Output: ' . $output;
}

say "Example 1:";
solution([8, 1, 9]);

say "\nExample 2:";
solution([8, 6, 7, 1, 0]);

say "\nExample 3:";
solution([1]);
