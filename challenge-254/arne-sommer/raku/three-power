#! /usr/bin/env raku

unit sub MAIN ($n is copy where $n ~~ UInt, :v($verbose));

while $n > 3
{
  print ": $n / 3 -> " if $verbose;
  $n /= 3;
  say $n if $verbose;
  last if $n != $n.Int;
}

say $n == 0|3 ?? 'true' !! 'false';
