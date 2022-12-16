sub is-special ($n) {
    # return True if $n.chars == 1;
    my $h = set $n.comb;
    return $h.elems == $n.chars;
}

for 15, |(32..45), 1232, 1233, 1234 -> $m {
    my $count = $m <= 9 ?? $m !!  9;
    for 10..$m -> $i {
        $count++ if is-special $i;
    }
    say "$m \t -> $count";
}
