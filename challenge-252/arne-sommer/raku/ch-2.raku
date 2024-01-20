#! /usr/bin/env raku

unit sub MAIN (UInt $n is copy, :v(:$verbose));

my @array;

if $n % 2
{
  @array = (0,);
  say ": Odd number, added middle zero" if $verbose;
}

for 1 .. $n div 2 -> $i
{
  @array.push:     $i;
  @array.unshift: -$i;

  say ": Added { -$i } at front and $i at end" if $verbose;
}

say "({ @array.join(", ") })";
