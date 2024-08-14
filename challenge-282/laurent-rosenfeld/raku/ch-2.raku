sub changing-key ($in) {
    my $count = 0;
    my @letters = $in.lc.comb;
    my $old = shift @letters;
    for @letters -> $let {
        $old = $let and $count++ if $let ne $old;
    }
    return $count;
}

my @tests = 'pPeERrLl', 'rRr', 'GoO';
for @tests -> $test {
    printf "%-10s => ", $test;
    say changing-key $test;
}
