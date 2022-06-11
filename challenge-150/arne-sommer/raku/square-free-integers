#! /usr/bin/env raku

unit sub MAIN (Int $limit where $limit > 0 = 500);

say (1 .. $limit).grep( { factors($_).repeated.elems == 0 }).join(", ");

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
