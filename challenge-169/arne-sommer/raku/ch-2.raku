#! /usr/bin/env raku

unit sub MAIN (Int :c(:$count) where $count > 0 = 20, :$powerful, :$perfect);

my $bn;


if ($powerful && ! $perfect)
{
  $bn := (1 .. Inf).grep( *.&is-powerful );
}
elsif ($perfect && !$powerful)
{
  $bn := (1 .. Inf).grep( *.&is-perfect );
}
else
{
  $bn := (1 .. Inf).grep( *.&is-achilles );
}

say $bn[^$count].join(", ");

sub factors ($number is copy)
{
  return (1)       if $number == 1;
  return ($number) if $number.is-prime;

  my @factors;

  for (2 .. $number div 2).grep( *.is-prime) -> $candidate
  {
    while $number %% $candidate
    {
      @factors.push: $candidate;
      $number /= $candidate;
    }
  }

  return @factors;
}

sub divisors ($number, :$not-self, :$not-one)
{
  my @divisors;
  
  for ($not-one ?? 2 !! 1) .. $number/2 -> $candidate
  {
    @divisors.push: $candidate if $number %% $candidate;
  }
  
  @divisors.push: $number unless $not-self;
  
  return @divisors;
}

sub is-powerful ($number)
{
  return True if $number == 1;

  my @factors = factors($number);

  my $b = @factors.Bag;

  return all($b.values) > 1;
}

sub is-perfect ($number)
{
  return True if $number <= 1;

  my @divisors = divisors($number, :not-self, :not-one);

  return False unless @divisors.elems;

  for @divisors -> $divisor
  {
    my $current = $divisor;

    $current *= $divisor while $current < $number;

    return True if $current == $number;
  }

  return False;
}

sub is-achilles ($number)
{
  return False unless $number.&is-powerful;
  return False if     $number.&is-perfect;
  return True;
}
