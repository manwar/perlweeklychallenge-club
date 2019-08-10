#! /usr/bin/env perl6

multi proper-divisors (2) { return (1); } 

multi proper-divisors (Int $number where $number > 2) 
{
  return (1) if $number.is-prime; 

  my @divisors = (1);
  for 2 .. ($number -1) -> $candidate 
  {
    @divisors.push: $candidate if $number %% $candidate;
  }
  return @divisors;
}

my @sum;

for 2 .. Inf -> $current
{
  my $sum = proper-divisors($current).sum;
  @sum[$current] = $sum;

  next if $sum == 1 || $sum >= $current;

  my $new-sum = @sum[$sum] // next;

  next if $new-sum == 1 || $new-sum >= $current || $sum == $new-sum;

  if $sum == @sum[$new-sum]
  {
    say "(@sum[$sum], $sum)";
    last;
  }
}
