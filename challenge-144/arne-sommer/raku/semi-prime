#! /usr/bin/env raku

subset PosInt of Int where * > 0;

unit sub MAIN (PosInt $limit = 100);

my @primes = (1 .. $limit div 2).grep( *.is-prime);

my @result;

for @primes -> $a
{
  for @primes -> $b
  {
    my $product = $a * $b;
    @result.push: $product if $product <= $limit;   
  }
}

say @result.sort.squish.join(", ");
