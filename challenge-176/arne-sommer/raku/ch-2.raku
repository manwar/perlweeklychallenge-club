#! /usr/bin/env raku

unit sub MAIN (Int $limit where $limit > 0 = 100);

say (10 .. $limit).grep( *.&is-reversible ).join(", ");

sub is-reversible ($number)
{
  my $sum = $number + $number.flip;

  return $sum !~~ /<[02468]>/;
}
