#! /usr/bin/env raku

unit sub MAIN (Int $number where $number > 0,
               Int $mode where $mode == any(0|1),
	       :v(:$verbose));

my @factors = factors($number);

say ": Factors: { @factors.join(",") }" if $verbose;

say $mode ?? @factors.elems !! @factors.unique.elems;

sub factors ($number is copy)
{
  return (1)       if $number == 1;
  return ($number) if $number.is-prime;

  my @factors;

  for (2 .. $number div 2).grep( *.is-prime ) -> $candidate
  {
    while $number %% $candidate
    {
      @factors.push: $candidate;
      $number /= $candidate;
    }
  }
    
  return @factors;
}
