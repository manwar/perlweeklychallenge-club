#! /usr/bin/env raku

unit sub MAIN (Int $m where $m > 0, Int $n where $n > 0, :a($all));

my $primes := (2 .. $m).grep( *.is-prime );

for $primes.combinations($n) -> @combination
{
  my $sum = @combination.sum;

  if $sum == $m
  {
    say @combination.join(", ");
    last unless $all;
  }
}
