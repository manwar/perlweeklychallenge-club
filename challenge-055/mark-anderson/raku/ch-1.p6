sub MAIN(Str $binary where * ~~ /^<[01]>+$/) {
    my @LR = (^$binary.chars).combinations: 2;
    @LR.push(($_, $_)) for ^$binary.chars;

    my %results;

    for @LR -> ($l, $r) {
        my $left   = $binary.substr(0, $l);
        my $middle = $binary.substr($l, $r+1-$l);
        my $right  = $binary.substr($r+1);

        $middle = (("0b" ~ $middle) +^ ("0b" ~ "1" x $middle.chars)).base(2);

        %results{"($l, $r)"} = ($left ~ $middle ~ $right).comb(/1/).elems;
    }

    .say if .value == %results.values.max for %results.sort;
}
