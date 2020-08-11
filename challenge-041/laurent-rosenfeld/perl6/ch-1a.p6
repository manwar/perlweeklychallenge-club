use v6;

my @primes = grep {.is-prime}, 1..25;
my $set = (grep {$_ <= 50}, map {[*] $_}, (@primes xx 3).flat.combinations: 2..3)
    ∪ (grep {$_ <= 50}, map {[*] $_}, (@primes[0..4] xx 5).flat.combinations: 5);
say $set.keys.sort
