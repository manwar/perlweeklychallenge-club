#! /usr/bin/env raku

unit sub MAIN (Int $limit = 50, :$verbose);

for 1 .. $limit -> $current
{
  my @divisors = divisors($current);
  my $elems    = @divisors.elems;
  say ": $current: Divisors: { divisors($current) } Elements: $elems" if $verbose;
  say "$current is an attractive number (with divisors: @divisors[])" if $elems.is-prime;
}

sub divisors (Int $number is copy)
{
  return (1) if $number == 1;
  return ($number) if $number.is-prime;

  my @divisors;

  for 2 .. ($number -1) -> $candidate
  {
    next unless $candidate.is-prime;
  
    while ($number %% $candidate)
    {
      @divisors.push: $candidate;
      $number div= $candidate;
    }
    if $number.is-prime
    {
      @divisors.push: $number;
      last;
    }
  }
  return @divisors;
}
