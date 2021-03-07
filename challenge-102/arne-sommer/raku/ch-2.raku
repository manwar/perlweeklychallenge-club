#! /usr/bin/env raku

unit sub MAIN (Int $N where $N > 0);

my $position = $N;
my $string   = "";

while ($position > 1)
{
  my $prefix = $position ~ '#';

  $string = $prefix ~ $string;
  $position -= $prefix.chars;
}

say $string.chars == $N
  ?? $string
  !! "#$string";
