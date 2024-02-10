#! /usr/bin/env raku

unit sub MAIN ($s where $s.chars > 0,
               $t where $t.chars == $s.chars + 1,
               :v(:$verbose));

my $t-bag = $t.comb.Bag;
my $s-bag = $s.comb.Bag;
my $add   = $t-bag (^) $s-bag;

if $verbose
{
  say ":s: { $s-bag.raku }";
  say ":t: { $t-bag.raku }";
  say ":addition: { $add.raku }";
}

die "Not one additional letter, but { $add.elems } ({ $add.keys.join(",") })" unless $add.elems == 1;

say $add.keys.first;
