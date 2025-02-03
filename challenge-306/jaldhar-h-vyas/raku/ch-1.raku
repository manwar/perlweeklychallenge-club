#!/usr/bin/raku

sub MAIN(
    *@ints
) {
    my $sum;

    for 1, 3 ... @ints.elems -> $i {
        for 0 .. @ints.elems - $i -> $j {
            $sum += @ints[$j ..^ $j + $i].sum;
        }
    }

    say $sum;
}
