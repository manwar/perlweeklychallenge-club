#! /usr/bin/env raku

unit sub MAIN (Int $count where $count > 0 = 19);

my $ds := (^Inf).grep( *.&is-disarium );

say $ds[^$count].join(", ");

sub is-disarium ($number)
{
  my $position = 0;
  my $sum      = 0;

  for $number.comb -> $digit
  {
    $sum += $digit ** ++$position;
  }

  return $sum == $number;
}
