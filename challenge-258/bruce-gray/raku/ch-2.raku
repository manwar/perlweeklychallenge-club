sub pop-count { $^n.base(2).comb('1').elems }

sub pop-count-fast ($n is copy) {
    constant @bits_per_2bytes = [X+] (0,1) xx 16; # Bwaahaahaa!
    my $c = 0;
    while $n {
        $c += @bits_per_2bytes[$n +& 0xFFFF];
        $n +>= 16;
    }
    return $c;
}

sub task2 ( UInt $k, @ns --> UInt ) {
    # More concise alternatives:
    # return @ns.grep({ pop-count($++) == $k }).sum;
    # return @ns.pairs.map({ .value if pop-count(.key) == $k }).sum;

    my &pop-count-is-k = *.&pop-count == $k;

    my @wanted_keys = @ns.keys.grep: &pop-count-is-k;

    return @ns[ @wanted_keys ].sum;
}


use Test; plan +my @tests =
    ( 17, 1, (2, 5, 9, 11, 3) ),
    ( 11, 2, (2, 5, 9, 11, 3) ),
    (  2, 0, (2, 5, 9, 11, 3) ),
;
for @tests -> ( $expected, $in_k, @in_ints ) {
    is task2($in_k, @in_ints), $expected;
}
