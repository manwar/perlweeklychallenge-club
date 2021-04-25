#! /usr/bin/env raku

unit sub MAIN ($limit = 20, :v(:$verbose));

my $chowla := gather
{
  my $index = 1;
  loop
  {
    my @divisors = divisors($index, :not-self, :not-one);
    say "$index with divisors: { @divisors.join(", ") }" if $verbose;

    take @divisors.sum;
    $index++;
  }
}

say $chowla[^$limit].join(", ");

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
