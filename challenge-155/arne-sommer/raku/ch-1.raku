#! /usr/bin/env raku

subset PositiveInt of Int where * >= 1;

unit sub MAIN (PositiveInt $limit = 20, :v(:$verbose));

my $primes := (2 .. Inf).grep( *.is-prime ).cache;
my $fn     := (1 .. Inf).map( { fn($_) });

say $fn.head(min(10, $limit * 2)).sort.squish.head($limit).join(", ");

sub fn ($index)
{
  my $product = [*] $primes[^$index];

  say ": Index: $index. Prime: $primes[$index-1]. Product: $product" if $verbose;

  for 2 .. Inf -> $add
  {
    return $add if ($product + $add).is-prime;
  }
}
