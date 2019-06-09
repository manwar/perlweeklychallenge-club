#! /usr/bin/env perl6

my $c = 0;

loop
{
  my $f = celcius2fahrenheit($c);
  if $f <= $c
  {
    say "Fahrenheit ($f) and Celsius ($c) are equal(ish).";
    last;
  }
  $c--;
}

sub celcius2fahrenheit ($c)
{
  return $c * 1.8 + 32;
}
