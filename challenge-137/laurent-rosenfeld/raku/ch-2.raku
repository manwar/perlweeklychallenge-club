use v6;

sub is-lychrel (UInt $m) {
    my $n = $m;
    for 1..500 -> $i {
        return "$m is a Lychrel candidate. Reached the 1e7 limit"
            if $n > 10_000_000;
        $n += $n.flip;
        #`[say $n and] return 0 if $n == $n.flip;
    }
    return "$m is a lychrel candidate (made 500 iterations)";
}
for 10...20, 30, 50, 100, 196 -> $test {
    say "$test -> ", is-lychrel $test;
}
