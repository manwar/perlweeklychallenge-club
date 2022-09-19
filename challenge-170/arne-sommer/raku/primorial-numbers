#! /usr/bin/env raku

unit sub MAIN (Int $count where $count > 0 = 10);

my $primes := (1 .. *).grep( *.is-prime );

my $primorial := gather
{
  take my $prev = 1;

  for $primes -> $prime
  {
    take $prev = $prev * $prime;
  }
}

say $primorial[^$count].join(", ");
