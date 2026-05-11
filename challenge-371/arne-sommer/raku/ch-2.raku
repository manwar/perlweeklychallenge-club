#! /usr/bin/env raku

unit sub MAIN (*@nums where @nums.elems > 1 && all(@nums) ~~ Int,
               :v(:$verbose));

my @match;

for (^@nums.elems).combinations(2 .. @nums.elems -1) -> @indices
{
  my $values      = @nums[@indices].sum;
  my $positions   = @indices.sum + @indices.elems;
  my $equilibrium = $values == $positions;

  @match.push: @nums[@indices] if $equilibrium;

  say ": ({ @nums[@indices].join(",") }) -> I: @indices[] -> V: $values -> P: $positions { $equilibrium ?? "match" !! "" }" if $verbose;
}

say @match
  ?? @match.map({ "(" ~ $_.join(",") ~ ")" }).join(", ")
  !! '()';
