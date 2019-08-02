#! /usr/bin/env perl6

unit sub MAIN ($count = 10);

my $primes := (1 .. *).grep(*.is-prime);

my $euclid-numbers := gather
{
  for 1 .. *
  {
    take 1 + [*] $primes[^$_];
  }
}

say "{ ($_ + 1).fmt('%' ~ $count.chars ~ 'd') }: $euclid-numbers[$_]" for ^$count;
