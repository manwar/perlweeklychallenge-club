sub MAIN (Int $length, Int $max-val, Str $list) {
    my @L = | $list.split(" ") xx $length;
    my @out;
    for @L.combinations: 1..$length -> $seq {
        for $seq.permutations>>.join('') -> $num {
            push @out, +$num if $num < $max-val
                and $num.Int.chars == $length;
        }
    }
    .say for @out.sort.squish;
}
