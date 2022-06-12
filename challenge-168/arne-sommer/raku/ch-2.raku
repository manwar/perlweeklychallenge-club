#! /usr/bin/env raku

unit sub MAIN (Int $number is copy where $number > 1);

$number = factors($number).join.Int until $number.is-prime;

say $number;

sub factors ($number is copy)
{
  return (1)       if $number == 1;
  return ($number) if $number.is-prime;

  my @factors;

  for (2 .. $number div 2).grep( *.is-prime) -> $candidate
  {
    while $number %% $candidate
    {
      @factors.push: $candidate;
      $number /= $candidate;
    }
  }
    
  return @factors;
}
