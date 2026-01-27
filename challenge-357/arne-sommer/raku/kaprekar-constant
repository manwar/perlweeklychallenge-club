#! /usr/bin/env raku

unit sub MAIN (Int $int is copy where 1000 <= $int <= 9999, :v(:$verbose));

my $iterations   = 0;
constant $target = 6174;

while $int != $target
{
  $iterations++;

  my $small = $int.comb.sort.join;
  my $large = $small.flip;

  $large *= 10 while $large < 1000;

  $int      = $large - $small;

  say ": $iterations: $large - $small = $int" if $verbose;

  { say "-1"; exit; } unless $int;
}

say $iterations;