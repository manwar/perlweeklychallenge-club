#!/usr/bin/env raku

sub lexicographic-order(@arr)
{
  my $count = 0;
  @arr.map({my $s = $_.comb.sort.join;
	    $count++ if $s ne $_ && $s.flip ne $_});
  $count
}

say lexicographic-order(["abc", "bce", "cae"]);
say lexicographic-order(["yxz", "cba", "mon"]);

