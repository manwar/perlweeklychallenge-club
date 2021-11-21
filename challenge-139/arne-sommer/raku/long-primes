#! /usr/bin/env raku

unit sub MAIN (Int $count where $count > 0 = 5);

my $long-primes := (1..Inf).grep( { is-long-prime($_) } );

sub is-long-prime ($p)
{
  return False unless $p.is-prime;

  my ($zero, $pattern) = (1/$p).base-repeating;

  return ($pattern.chars == $p -1);
}

say $long-primes[^$count].join(", ");
