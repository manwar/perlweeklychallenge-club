#! /usr/bin/env raku

unit sub MAIN ($str where $str.chars > 0, :v(:$verbose));

my $bag  = $str.comb.grep(/<[a..z A..Z]>/).Bag;
my @even = $bag.grep( *.value %% 2 )>>.key;

if $verbose
{
  say ": Bag: { $bag.raku }";
  say ": Even letters: { @even.join(", ") }";
}

say @even.elems == 0;