#! /usr/bin/perl6

use Test;
plan 2;

is-deeply(
  ci([[1,4],[3,5],[6,8],[12,13],[3,20]]),
  [[3,5],[3,20]],
  'example 1');

is-deeply(
  ci([[3,4],[5,7],[6,9],[10,12],[13,15]]),
  [[6,9],],
  'example 2');

sub ci(@a) {
  my @o;
  for (1..@a.end) -> $i {
    for (0..$i-1) -> $j {
      if ((@a[$i][0] >= @a[$j][0] &&
             @a[$i][0] <= @a[$j][1]) ||
             (@a[$i][1] >= @a[$j][0] &&
              @a[$i][1] <= @a[$j][1]) ||
              (@a[$i][0] <= @a[$j][0] &&
               @a[$i][1] >= @a[$j][1])
                ) {
        push @o,@a[$i];
        last;
      }
    }
  }
  return @o;
}
