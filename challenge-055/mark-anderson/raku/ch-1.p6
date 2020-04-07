sub MAIN(Str $binary where $binary ~~ /<[01]>/) {
    my @LR = (0 .. $binary.chars-1).combinations: 2;

    for (0 .. $binary.chars-1) -> $n {
        @LR.push(($n, $n));
    }

    my %results;

    for @LR -> ($l, $r) {
        my $left   = $binary.substr(0, $l);
        my $middle = $binary.substr($l, $r+1-$l);
        my $right  = $binary.substr($r+1);

        $middle = (("0b" ~ $middle).Int +^ ("0b" ~ "1" x $middle.chars).Int)
                  .fmt("%0" ~ $middle.chars ~ "b");

        %results{"($l, $r)"} = ($left ~ $middle ~ $right).comb(/1/).elems;
    }

    .say if .value == %results.values.max for %results.sort;
}
