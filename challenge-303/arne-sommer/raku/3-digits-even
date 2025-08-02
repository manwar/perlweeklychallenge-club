#! /usr/bin/env raku

unit sub MAIN (*@ints where @ints.elems > 2 && all(@ints) eq any(0..9),
               :v(:$verbose));

my @output;

for @ints.combinations(3).sort.unique(:with(&[eqv])) -> @comb
{
  my @perms = @comb.permutations>>.join;
  my @even3 = @perms.grep({ $_.substr(0,1) ne "0" && $_.substr(2,1) %% 2 }).unique;
  say ": Comb: @comb[] -> Perms: @perms[] -> Even3: @even3[]" if $verbose;
  @output.append: @even3;
}

say "({ @output.sort.squish.join(", ")})";
