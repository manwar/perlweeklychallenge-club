#! /usr/bin/env raku

subset NuDe of Str where * ~~ /^\d+\/\d+$/;

unit sub MAIN (NuDe $fraction);

my $parent      = parent($fraction);
my $grandparent = parent($parent);

say "parent = \'$parent\' and grandparent = \'$grandparent\'";

sub parent (NuDe $fraction)
{
  my (Int $numerator, Int $denominator) = $fraction.split("/")>>.Int;

  return "0/0" if $numerator == $denominator == 1;

  $numerator < $denominator
    ?? return $numerator ~ "/" ~ $denominator - $numerator
    !! return $numerator - $denominator ~ "/" ~ $denominator;
}