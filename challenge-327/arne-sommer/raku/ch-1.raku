#! /usr/bin/env raku

unit sub MAIN (*@ints where @ints.elems > 0 && all(@ints) ~~ Int,
               :v(:$verbose));

my $max = @ints.elems;
my $set = @ints>>.Int.grep( 0 < * <= $max).Set;

if $verbose
{
  say ": Range: 1 .. $max";
  say ": Matches: { $set.keys.sort.join(", ") }";
}

my @missing = (1..$max).grep({ ! so $set{$_} });

say "({ @missing.join(", ") })";
