use v6;

sub find-self-descriptive (Int $b) {
    return check-all-cases ($b) if $b < 7;
    my $dec-num = ($b - 4) * $b ** ($b - 1) + 2 * $b ** ($b - 2) + $b ** ($b - 3) + $b ** 3;
    my $base-num = $dec-num.base($b);
    return "Number in base $b: $base-num; decimal: $dec-num";
}

sub check-all-cases (Int $base) {
    for $base ** ($base -1) .. $base ** $base -1 -> $num {
        my $num-in-b = $num.base($base);
        next unless $num-in-b ~~ /0$/;
        my @digits = $num-in-b.comb;
        next if $base != [+] @digits;
        my $success = True;
        for 0..$base - 1 -> $rank {
            if (+ $num-in-b.indices($rank) != @digits[$rank]) {
                $success = False;
                last;
            }
        }
        return "Number in base $base: $num-in-b; decimal: $num" if $success;
    }
    return "No self-descriptive number for base $base";
}

say .&find-self-descriptive for 1 .. 10;
