#! /usr/bin/env raku

unit sub MAIN (Int $n where $n > 0);

say + is-esthetic($n);

sub is-esthetic ($number)
{
  my @digits = $n.comb;

  my $current = @digits.shift;

  while @digits.elems
  {
     return False if all ($current != @digits[0] + 1), ($current != @digits[0] - 1);
     $current = @digits.shift;
  }

  return True;
}
