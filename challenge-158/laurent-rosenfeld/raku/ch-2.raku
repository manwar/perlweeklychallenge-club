for 1..Inf -> $n {
    my $p = 3 * $n ** 2 + 3 * $n + 1;
    last if $p > 1000;
    print "$p, " if $p.is-prime;
}
say " ";
