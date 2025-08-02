#!/usr/bin/raku

sub MAIN(
    $k,
    *@ints
) {
    @ints
    .keys
    .map({ $_.base(2) })
    .grep({
        $_
        .comb
        .grep({ $_ == 1 })
        .elems == $k
    })
    .map({ @ints["0b$_"] })
    .sum
    .say;
}