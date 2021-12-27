#! /usr/bin/env raku

subset PosInt of Int where * >= 1;
subset Digit  of Int where * == any(0..9);

unit sub MAIN (PosInt $m, Digit $n, :v(:$verbose));

my @divisors = divisors($m);
my @result   = @divisors.grep({ /$n$/ }) ;

say ": - Ending with $n: { @result.join(", ") }" if $verbose;

say @result.elems;

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
