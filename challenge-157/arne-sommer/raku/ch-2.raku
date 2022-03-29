#! /usr/bin/env raku

unit sub MAIN (Int $n where $n > 3, :v(:$verbose));

for 2 .. $n -2 -> $base
{
  my @digits = $n.polymod($base, $base ... *);

  say ":N:$n in base $base -> { @digits.join(",") }" if $verbose;

  if [==] @digits { say 1; exit; }
}

say 0;
