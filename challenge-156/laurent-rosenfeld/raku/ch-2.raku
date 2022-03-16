sub is-weird (Int $n where * > 0) {
    my @divisors = grep {$n %% $_}, 1..$n/2;
    return False if @divisors.sum <= $n;
    for @divisors.combinations: 2..@divisors.elems -> $subset {
        return False if $subset.sum == $n;
    }
    True;
}

for 2..1000 -> $m {
    say "Found $m" if is-weird($m);
}
