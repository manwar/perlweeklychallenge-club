use v6;

sub MAIN (Int $n where * > 0, Int $k where * > 0) {
    (1..$n).permutations[$k - 1].say;
}
