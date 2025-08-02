#!/usr/bin/raku

sub MAIN(
    *@ints
) {
    my $total = 0;

    while @ints.elems > 1 {
        $total += @ints.shift ~ @ints.pop;
    }

    if @ints.elems {
        $total += @ints[0];
    }

    say $total;
}