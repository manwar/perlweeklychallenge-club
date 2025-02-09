#! /usr/bin/env raku

unit sub MAIN (*@ints where @ints.elems >= 2 && all(@ints) ~~ Int,
               :v(:$verbose));

my @ordered = @ints.sort;

my @indices;

for ^@ints.elems -> $index
{
  if @ints[$index] == @ordered[$index]
  {
    say ": Index $index: @ints[$index] == @ordered[$index] *" if $verbose;
  }
  else
  {
    @indices.push: $index;
    say ": Index $index: @ints[$index] != @ordered[$index]" if $verbose;
  }
}

say "({ @indices.join(", ") })";
