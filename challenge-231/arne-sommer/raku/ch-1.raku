#! /usr/bin/env raku

unit sub MAIN (*@ints where @ints.elems == @ints.unique.elems > 0 && all(@ints) ~~ Int);

if @ints.elems < 3
{
  say "-1";
}
else
{
  my @min-max = @ints.grep( @ints.min < * < @ints.max );
  say "({ @min-max.join(", ") })";
}
