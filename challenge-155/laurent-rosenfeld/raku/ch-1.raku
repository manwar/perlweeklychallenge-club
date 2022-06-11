my @primes = grep { .is-prime }, 1..Inf;
my @primorials = (0, | (gather { take ([*] @primes[0..$_-1]) for 1..20}));
# say @primorials[0..8];  # (0 2 6 30 210 2310 30030 510510 9699690)

sub find-fortunate (Int $n) {
    my $pn = @primorials[$n-1];
    # say $pn;
    for 2..Inf -> $m {
        return $m if is-prime $pn + $m;
    }
}
my $fortunates = (map { find-fortunate $_ }, 2..20).Set;
say ($fortunates.keys.sort)[0..7];
