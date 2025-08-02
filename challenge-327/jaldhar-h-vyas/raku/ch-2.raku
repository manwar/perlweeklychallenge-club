#!/usr/bin/raku

sub MAIN(
    *@ints
) {
    my %differences;

    for @ints».Int.combinations(2) -> $pair {
        %differences{([-] @$pair).abs}.push($pair);
    }

    %differences{%differences.keys».Int.min}
        .map({ "[@$_.sort({ $^a <=> $^b }).join(q{,})]" })
        .sort
        .join(q{, })
        .say;
}