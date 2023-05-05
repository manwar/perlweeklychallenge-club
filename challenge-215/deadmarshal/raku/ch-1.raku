#!/usr/bin/env raku

sub odd-one-out(@arr)
{
  my $count = 0;
  for @arr -> $s
  {
    $count++ if $s ne $s.comb.sort.join;
  }
  $count
}

say odd-one-out(['abc','xyz','tsu']);
say odd-one-out(['rat','cab','dad']);
say odd-one-out(['x','y','z']);

