#! /usr/bin/env perl6

my \p := (1 .. Inf).grep(*.is-prime);

my @strong;
my @weak;

for 1 .. Inf -> \n
{
  if p[n] > ( p[n-1] + p[n+1] ) / 2
  {
    @strong.push: p[n];
  }
  elsif p[n] < ( p[n-1] + p[n+1] ) / 2
  {
    @weak.push: p[n];
  }

  last if @strong.elems >= 10 && @weak.elems >= 10;
}

say "Strong primes: { @strong[^10].join(", ") }.";
say "Weak primes: { @weak[^10].join(", ") }.";
