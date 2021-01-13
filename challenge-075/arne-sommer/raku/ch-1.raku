#! /usr/bin/env raku

subset NonNegativeInt of Int where * >= 0;

unit sub MAIN (NonNegativeInt $S where $S >= 1,
               *@C where @C.elems >= 1     &&
	         all(@C) ~~ NonNegativeInt &&
		 all(@C) <= $S,
               :v(:$verbose));

my @coins = @C.unique;
my @source;

for @coins -> $coin
{
  @source.append: $coin xx ($S div $coin);
}

if $verbose
{
  say ": Sum: $S";
  say ": Coins: " ~ @C.join(", ");
  say ": Unique coins: " ~ @coins.join(", ");
  say ": Source: " ~ @source.join(", ");
}

.join(", ").say for @source.combinations(1..$S).grep({ .sum == $S }).unique(:with(&[eqv]));

