#!/usr/bin/env raku

sub maximise-greatness(@arr)
{
  my $max = 0;
  for @arr.permutations -> @perm {
    my $count = (0..@arr.end).grep({@arr[$_] < @perm[$_]}).elems;
    $max = $count if $count > $max;
  }
  $max
}

say maximise-greatness([1,3,5,2,1,3,1]);
say maximise-greatness([1,2,3,4]);

