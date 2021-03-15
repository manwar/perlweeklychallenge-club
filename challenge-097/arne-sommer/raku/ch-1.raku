#! /usr/bin/env raku

subset AZ-space of Str where /^ <[ A .. Z \s ]>+ $/;
subset PosInt of Int where -25 <= $_ <= 25;

unit sub MAIN (AZ-space $S = 'THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG',
               PosInt $N = 3);

say caesar($S, $N);

sub caesar ($string, $shift)
{
  return $string.ords.map({ $_ == 32 ?? 32 !! (($_ - $shift - 65) % 26 ) + 65 }).chrs;
}
