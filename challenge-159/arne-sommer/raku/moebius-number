#! /usr/bin/env raku

unit sub MAIN (Int $n where $n > 0, :v(:$verbose));

my @prime-factors = factors($n, :include-one);

say ": Factor count: { @prime-factors.elems } (Factors: { @prime-factors.join(", ")})" if $verbose;

if @prime-factors.repeated.elems
{
  say 0;
}
else
{
  say @prime-factors.elems %% 2 ?? -1 !! 1;
}

sub factors ($number is copy, :$include-one)
{
  return (1) if $number == 1;

  if $number.is-prime
  {
    return :$include-one ?? (1, $number) !! ($number);
  }
  
  my @factors = $include-one ?? 1 !! ();

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
