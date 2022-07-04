#! /usr/bin/env raku

unit sub MAIN (Int :c(:$count) where $count > 0 = 20, :v(:$verbose));

my $abundant := (1 .. Inf).grep( *.&is-abundant );

say $abundant[^$count].join(", ");

sub divisors ($number, :$not-self, :$not-one)
{
  my @divisors;
  
  for ($not-one ?? 2 !! 1) .. $number/2 -> $candidate
  {
    @divisors.push: $candidate if $number %% $candidate;
  }
  
  @divisors.push: $number unless $not-self;
  say ": $number -> @divisors[] = { @divisors.sum }" if $verbose;  
  return @divisors;
}

sub is-abundant ($number)
{
  return $number % 2 && divisors($number, :not-self).sum > $number;
  # return $number % 2 && divisors($number).sum > $number * 2;
}
