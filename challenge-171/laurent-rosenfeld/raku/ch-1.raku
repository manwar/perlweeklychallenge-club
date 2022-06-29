sub is-abundant (Int $n where * > 0) {
    my @divisors = grep {$n %% $_}, 1..$n/2;
    return @divisors.sum > $n ?? True !! False;
}
my $count = 0;
for 1, 3 ... Inf -> $n {
    if is-abundant $n {
        say $n;
        last if ++$count >= 20;
    }
}
