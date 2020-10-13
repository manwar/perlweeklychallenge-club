unit sub MAIN(UInt $m, UInt $n);

say common-factors($m, $n);

sub common-factors($m, $n) {

    sub factor($i) {
        (1..($i div 2)).grep($i %% *);
    }

    (factor($m) (&) factor($n)).keys.sort.join(", ").List;
}
