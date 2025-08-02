#! /usr/bin/env raku

unit sub MAIN (*@ints where @ints.elems > 0 && all(@ints) ~~ UInt,
               :v(:$verbose));

my $total = 0;

for @ints.combinations(1..Inf) -> @comb
{
  my $xor = [+^] @comb;
  $total += $xor;

  say ": [{ @comb.join(",") }] -> $xor" if $verbose;
}

say $total;
