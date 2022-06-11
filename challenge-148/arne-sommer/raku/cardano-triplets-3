#! /usr/bin/env raku

use Math::Root;

unit sub MAIN (Int :$limit = 21, :$count = 5, :v(:$verbose));

my $ct := gather
{
  for 1 .. $limit -> $a
  {
    for 1 .. $limit -> $b
    {
      for 1 .. $limit -> $c
      {
        my $left  = $a + $b * root($c);
	my $right = $a - $b * root($c);

        say ": Considering $a, $b, $c" if $verbose;
        take ($a, $b, $c) if cube-root($left) + cube-root($right) == 1;
      }
    }
  }
}

$ct[^$count].map({ say "(" ~ @$_.join(", ") ~ ")" if $_ });

sub cube-root ($number)
{
  return root($number, 3) if $number >= 0;

  return - root(- $number, 3);
}
