#! /usr/bin/env raku

unit sub MAIN (*@ints where @ints.elems > 1 && all(@ints) ~~ Int);

my $length = @ints.elems;
my @squareful;

PERM-LOOP:
for @ints.permutations.unique(:with(&[eqv])) -> @permutation
{
  for 0 .. $length -2 -> $index
  {
    my $sum  = @permutation[$index] + @permutation[$index +1];
    my $root = $sum.sqrt;
    next PERM-LOOP unless $root.Int == $root;
  }

  push(@squareful, @permutation);
}

say @squareful;
