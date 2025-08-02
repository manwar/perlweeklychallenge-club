#!/usr/bin/raku

sub MAIN(
    $k,
    *@ints
) {
    @ints
        .keys
        .combinations(2)
        .grep({ @ints[@$_[0]] == @ints[@$_[1]] && ([*] @$_) %% $k })
        .elems
        .say;
}