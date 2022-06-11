#! /usr/bin/env raku

unit sub MAIN (Int $n where $n > 0);

my @proper-divisors = divisors($n, :not-self);

say @proper-divisors.sum <= $n
  ?? 0
  !! + ! so any(@proper-divisors.combinations>>.sum) == $n;

sub divisors ($number, :$not-self, :$not-one)
{
  my @divisors;
  
  for ($not-one ?? 2 !! 1) .. $number/2 -> $candidate
  {
    @divisors.push: $candidate if $number %% $candidate;
  }
  
  @divisors.push: $number unless $not-self;

  return @divisors;
}
