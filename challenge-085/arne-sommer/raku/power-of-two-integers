#! /usr/bin/env raku

unit sub MAIN (Int $N where $N > 0, :v(:$verbose));

my @factors  = factors($N);
my @repeated = @factors.repeated;

if $verbose
{
  say ": Factors: { @factors.join(", ") }";
  say ": Repeated: { @repeated.join(", ") }";
}

say @repeated ?? 1 !! 0;

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
