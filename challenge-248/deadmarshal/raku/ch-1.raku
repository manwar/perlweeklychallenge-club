#!/usr/bin/env raku

sub shortest-distance($str,$c)
{
  my @arr = $str.comb;
  (0..@arr.end).map: {my $i = $_; ($str.indices($c).map: {abs $i - $_}).min}
}

say shortest-distance('loveleetcode','e');
say shortest-distance('aaab','b');

