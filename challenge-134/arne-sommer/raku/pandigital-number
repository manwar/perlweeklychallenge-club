#! /usr/bin/env raku

unit sub MAIN (Int $n where $n > 0 = 5);

my $pandigital-seq := gather
{
  my @base  = 0 .. 9;

  for 1 .. 9 -> $first
  {
    my @rest = (@base (-) $first).keys.sort;

    for @rest.permutations -> @permutation
    {
      take ($first ~ @permutation.join);
    }
  }
}

say $pandigital-seq[^$n].join(", ");
