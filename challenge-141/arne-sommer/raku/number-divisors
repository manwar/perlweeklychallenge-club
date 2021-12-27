#! /usr/bin/env raku

unit sub MAIN (Int $limit = 8, :v(:$verbose));

my $eight-divisors := (1..Inf).grep({ divisors($_).elems == 8 });

say $eight-divisors[^$limit].join(", ");

sub divisors ($number, :$not-self, :$not-one)
{
  my @divisors;
  
  for ($not-one ?? 2 !! 1) .. $number/2 -> $candidate
  {
    @divisors.push: $candidate if $number %% $candidate;
  }
  
  @divisors.push: $number unless $not-self;

  say ": $number has { @divisors.elems } divisors: { @divisors.join(", ") }" if $verbose;

  return @divisors;
}
