use v6;

sub stealthy-nums (UInt $n) {
    my @divisors = grep {$n %% $_}, 1..$n;
    my @div-pairs = grep { $_[0] * $_[1] == $n }, (@divisors X @divisors);
    # say @div-pairs;
    for @div-pairs.combinations: 2 -> $c {
        return $c if $c[0][0] + $c[0][1] - $c[1][0] - $c[1][1] == any(1, -1)
    }
    return False
}

for <36 12 6> -> $test {
    my $result = stealthy-nums $test;
    say "$test \t",
    $result ?? "1 -> $result" !! 0;
}
