#! /usr/bin/env raku

unit sub MAIN (Int $n where $n > 0, :v(:$verbose));

my $ugly-seq := gather
{
  take 1;

  for 2 .. Inf -> $candidate
  {
    my @prime-factors = factors($candidate);
    take $candidate if all(@prime-factors) == any(2,3,5);
  }
}

say ": Sequence: { $ugly-seq[^$n].join(", ") }" if $verbose;

say $ugly-seq[$n -1];

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
