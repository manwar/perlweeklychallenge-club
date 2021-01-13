#! /usr/bin/env raku

subset PositiveInt of Int where * > 0;

unit sub MAIN (PositiveInt $N, :v(:$verbose));

say (1..$N).combinations(2).map( *.&gcd ).sum;

sub gcd (@numbers)
{
  my %common = divisors(@numbers[0]) (&) divisors(@numbers[1]);
  my @common = %common.keys.sort;
  my $gcd    = @common[* -1];

  say ":: GCD(@numbers[0], @numbers[1]) -> $gcd" if $verbose;

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
  
  return @divisors;
}
