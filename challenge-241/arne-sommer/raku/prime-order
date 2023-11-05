#! /usr/bin/env raku

unit sub MAIN (*@int where all(@int) ~~ UInt && all(@int) > 0 && @int.elems == @int.unique.elems > 2, :v(:$verbose));

my %factor-count;

for @int -> $int
{
  my @factors = factors($int);
  %factor-count{$int} = @factors.elems;
  say ":Int $int -> factors: { @factors.join(",") } -> count: { @factors.elems }" if $verbose;
}

say @int.sort({ %factor-count{$^a} <=> %factor-count{$^b} || $^b <=> $^a });

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
