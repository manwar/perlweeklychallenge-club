#! /usr/bin/env raku

unit sub MAIN (UInt $S, :v(:$verbose));

recurse( (), $S);

sub recurse (@points, $left)
{
  $left == 0 && @points.join(" ").say && return;

  recurse((@points, 1).flat, $left -1) if $left >= 1;
  recurse((@points, 2).flat, $left -2) if $left >= 2;
  recurse((@points, 3).flat, $left -3) if $left >= 3;
}
