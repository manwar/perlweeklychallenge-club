use v6;

my @primes = grep { .is-prime }, map { 4 * $_ + 3},  0..1_000_000;
my @terms =  map { 1 / (1 - (1/($_ * $_)) ) }, @primes;
my $product = ([*] @terms) /2;
say $product ** (1/2);
