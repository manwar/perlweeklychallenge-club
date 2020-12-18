
sub MAIN (Int $N) {
    my @chars = $N.comb;

    # [1]
    my Str $out;

    # [2] $i..$j
    my $i = 0;
    my $j = 0;

    # [3] invariant: @chars[$i..$j] eq (@chars[$i] x ($j - $i))
    while $j < @chars.elems {
        $j++ while $j < @chars.elems && @chars[$i] eq @chars[$j];

        $out ~= ($j - $i) ~ @chars[$i];

        $i = $j;
    }

    say $out;
}
