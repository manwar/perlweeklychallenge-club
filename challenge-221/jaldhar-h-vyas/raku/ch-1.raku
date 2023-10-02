#!/usr/bin/raku

sub MAIN(
    $chars, *@words
) {
    my @chars = $chars.comb;
    @words
        .map({ $_.comb })
        .grep({ @$_ ⊆ @chars })
        .map({ @$_.elems })
        .sum
        .say;
}
