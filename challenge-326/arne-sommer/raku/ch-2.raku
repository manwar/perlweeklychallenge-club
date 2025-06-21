#! /usr/bin/env raku

subset PosInt of Int where * >= 0;

unit sub MAIN (*@ints where @ints.elems %% 2 && all(@ints) ~~ PosInt,
               :v(:$verbose));

my @output;

for @ints -> $i, $j
{
  my @add = $j.Int xx $i;

  say ": i:$i, j:$j -> @add[]" if $verbose;

  @output.append: @add;
}

say "({ @output.join(", ") })";
