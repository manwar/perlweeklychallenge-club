use v6;

sub count_divisors (UInt $m, UInt $n) {
    my @divisors = grep {$m %% $_}, 1..$m;
    my $last-digit = substr $n, *-1;
    my @eligible-divisors = grep { $last-digit == substr $_, *-1 }, @divisors;
    return @eligible-divisors.elems;
}

for (24, 34), (24, 12), (30, 45) {
  say "$_ -> ", count_divisors $_[0], $_[1];
}
