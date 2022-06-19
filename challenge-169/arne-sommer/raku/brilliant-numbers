#! /usr/bin/env raku

unit sub MAIN (Int :c(:$count) where $count > 0 = 20);

my $bn := (1 .. Inf).grep( *.&is-brilliant );

say $bn[^$count].join(", ");

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

sub is-brilliant ($number)
{
  my @factors = factors($number);
  return False unless @factors.elems == 2;
  return False unless @factors[0].chars == @factors[1].chars;
  return True;
}
