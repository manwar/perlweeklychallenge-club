#! /usr/bin/env raku

unit sub MAIN (Int $N where $N > 0);

my $match = False;

my $N2 = $N * $N;

for 1 .. $N2 -> $a
{
  for $a .. $N2 -> $b
  {
    for $b + 1 .. $N2 -> $c
    {
      next unless any($a, $b, $c) == $N;

      my $left  = $a * $a + $b * $b;
      my $right = $c * $c;

      last if $right > $left;
	     
      if $left == $right
      {
        say "($a, $b, $c)";
	$match = True;
      }
    }
  }
}

say "-1" unless $match;

