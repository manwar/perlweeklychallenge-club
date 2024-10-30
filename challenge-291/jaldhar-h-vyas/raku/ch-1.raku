#!/usr/bin/raku

sub MAIN(
    *@ints
) {
    my $mi = -1;

    for @ints.keys -> $i {
        if (@ints[0 .. $i - 1].sum // 0) == (@ints[$i + 1 .. *].sum // 0) {
            $mi = $i;
            last;
        }
    }

    say $mi;
}