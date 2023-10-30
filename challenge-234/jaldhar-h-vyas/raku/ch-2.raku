#!/usr/bin/raku

sub MAIN(
    *@ints
) {
    @ints
        .keys
        .combinations(3)
        .grep({
            my ($i, $j, $k) = @$_.map({ @ints[$_] });
            $i != $j && $j != $k && $k != $i;
        })
        .elems
        .say;
}