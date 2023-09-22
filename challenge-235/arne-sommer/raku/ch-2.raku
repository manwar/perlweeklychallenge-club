#! /usr/bin/env raku

unit sub MAIN (*@ints where all(@ints) ~~ Int);

my $seq := gather
{
  for @ints -> $int
  {
    take $int;
    take $int if $int == 0;
  }
}

say "({ $seq[^@ints.elems].join(", ") })";
