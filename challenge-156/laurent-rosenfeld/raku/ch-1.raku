my $count = 0;
for 2..* -> $n {
    if $n.base(2).comb.sum.is-prime {
        $count++;
        print "$n, " and next if $count < 10;
        say $n and last;
    }
}
