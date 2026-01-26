#! /usr/bin/env raku

unit sub MAIN (Int $int where $int > 0, :v(:$verbose));

my @fractions;
my @verbose;

for 1 .. $int -> $numerator
{
  for 1 .. $int -> $denominator
  {
    @fractions.push: $numerator / $denominator;
    @verbose.push: "$numerator/$denominator" if $verbose;
  }
}

say ": Added: { @verbose.join(", ") }" if $verbose;

say @fractions.sort.squish.map({ .numerator ~ "/" ~ .denominator }).join(", ");

