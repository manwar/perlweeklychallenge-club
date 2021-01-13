#! /usr/bin/env raku

for 1 .. 9 -> $a
{
  for 0 .. 9 -> $b
  {
    for 0 .. 9 -> $c
    {
      print "$a$b$c " unless ($a, $b, $c, $a * $b, $b * $c, $a * $b * $c).repeated;
    }
  }
}
say "";
