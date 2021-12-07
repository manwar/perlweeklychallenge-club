use v6;

sub has_8_divisors (UInt $n) {
    my @divisors = grep {$n %% $_}, 1..$n;
    return @divisors.elems == 8;
}

my $count = 0;
for 8..Inf -> $m {
    say $m and $count++ if has_8_divisors $m;
    last if $count >= 10;
}
