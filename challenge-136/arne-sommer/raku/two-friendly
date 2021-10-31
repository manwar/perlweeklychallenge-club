#! /usr/bin/env raku

subset PositiveInt of Int where * > 0;

unit sub MAIN (PositiveInt $m, PositiveInt $n, :v(:$verbose));

say + is-power-of-two(gcd($m, $n));

sub gcd ($a, $b)
{
  my @a      = divisors($a, :not-one)>>.Int;
  my @b      = divisors($b, :not-one)>>.Int;
  my @common = ( @a (&) @b ).keys.sort;

  say ": Common divisors: { @common.join(", ") }" if $verbose;

  my $gcd    = @common[* -1];

  return $gcd;
}

sub divisors ($number, :$not-self, :$not-one)
{
  my @divisors;
  
  for ($not-one ?? 2 !! 1) .. $number/2 -> $candidate
  {
    @divisors.push: $candidate if $number %% $candidate;
  }
  
  @divisors.push: $number unless $not-self;

  say ": $number has divisors: { @divisors.join(", ") }" if $verbose;

  return @divisors;
}

sub is-power-of-two ($integer)
{
  say ": $integer -> binary: { $integer.base(2) }" if $verbose;
  
  return $integer.base(2).comb.sum == 1;
}
