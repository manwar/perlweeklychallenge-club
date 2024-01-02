#! /usr/bin/env raku

unit sub MAIN (*@ints where @ints.elems > 0 && all(@ints) ~~ Int);

for ^@ints -> $i
{
  if $i % 10 == @ints[$i]
  {
    say $i;
    exit;
  }
}

say -1;
