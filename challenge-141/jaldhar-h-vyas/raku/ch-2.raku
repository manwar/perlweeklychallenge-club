#!/usr/bin/raku

sub MAIN(
    $m,
    $n
) {
    $m.comb
        .combinations(1 ..^ $m.chars)
        .map({ $_.join; })
        .grep({ $_ %% $n; })
        .elems
        .say;
}
