sub MAIN (Int $N) {
    # [1]
    my @chars = $N.comb;

    my Str $out;
    my $i = 0;
    my $j = 0;

    # [2] invariant: @chars[$i..$j] eq (@chars[$i] x ($j - $i))
    while $j < @chars.elems {
        $j++ while $j < @chars.elems && @chars[$i] eq @chars[$j];

        $out ~= ($j - $i) ~ @chars[$i];

        $i = $j;
    }

    say $out;
}
