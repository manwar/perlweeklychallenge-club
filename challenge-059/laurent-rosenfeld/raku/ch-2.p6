use v6;

sub compare (UInt $m, UInt $n) {
    my @a = $m.fmt('%08b').comb;
    my @b = $n.fmt('%08b').comb;
    my $cnt = 0;
    for 0..7 -> $i {
        $cnt++ if @a[$i] != @b[$i];
    }
    return $cnt;
}
my $diff = 0;
for @*ARGS.combinations(2) -> $seq {
    $diff += compare +$seq[0], +$seq[1];
}

say $diff;
