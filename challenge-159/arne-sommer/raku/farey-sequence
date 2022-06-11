#! /usr/bin/env raku

unit sub MAIN (Int $n where $n > 0, :v(:$verbose));

my @fs = (0/1, 1/1);

for 1 .. $n -1 -> $numerator
{
  for $numerator +1 .. $n -> $denominator
  {
    @fs.push: $numerator/$denominator;
  }
}

if $verbose
{
  say ":Unsorted: { @fs.join(", ") }";
  say ":Unsorted x/y: { @fs.map( *.nude.join("/") ).join(", ") }";
  say ":Sorted x/y: { @fs.sort.map( *.nude.join("/") ).join(", ") }";
}

@fs.sort.unique.map( *.nude.join("/") ).join(", ").say;
