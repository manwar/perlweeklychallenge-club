#! /usr/bin/env perl6

sub MAIN (Int $number where $number > 1)
{
  say prime-decomposition($number).join(" * ");
}

my $primes := (2 .. Inf).grep(*.is-prime);

sub prime-decomposition (Int $number is copy)
{
  my @decomposition;

  for $primes -> $prime
  {
    if $number.is-prime
    {
      @decomposition.push($number);
      last;
    }
    
    while $number %% $prime && $number != $prime
    {
      $number div= $prime;
      @decomposition.push($prime);
      last if $number.is-prime;
    }
  }
  return @decomposition;
}

