sub luhn ($in is copy) {
    $in ~~ s:g/\D+//;  # remove non-digits
    my @digits = $in.flip.comb;  # reverse and split
    for 0..@digits.end -> $i {
        # values for even indices don't change
        @digits[$i] = (2 * @digits[$i]).comb.sum unless $i %% 2;
    }
    return @digits.sum %% 10; # valid if sum end with a 0
}

for "17893729974", "178az93r729974", "178 9372 9 9  74",
    "4137 8947 1175 5904", "4137 8974 1175 5904" -> $test {
    printf "%-25s => ", $test;
    say luhn $test;
}
