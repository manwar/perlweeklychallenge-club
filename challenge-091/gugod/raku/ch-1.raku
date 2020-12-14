
sub MAIN (Int $N) {
    my @chars = $N.comb;
    my Str $out;
    my $i = 0;
    my $j = 0;
    while $j < @chars.elems {
        $j++ while $j < @chars.elems && @chars[$i] eq @chars[$j];
        $out ~= ($j - $i) ~ @chars[$i];
        $i = $j;
    }
    say $out;
}
