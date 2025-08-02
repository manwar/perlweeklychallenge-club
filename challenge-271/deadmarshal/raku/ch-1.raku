#!/usr/bin/env raku

sub maximum-ones(@arr)
{
  my $max = 0;
  for 0..@arr.end -> $i {
    my $c = @arr[$i].sum;
    $max = $i+1 if $c > $max
  }
  $max
}

say maximum-ones([[0,1],[1,0]]);
say maximum-ones([[0,0,0],[1,0,1]]);
say maximum-ones([[0,0],[1,1],[0,0]]);

