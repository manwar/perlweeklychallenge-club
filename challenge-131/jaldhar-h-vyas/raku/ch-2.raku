#!/usr/bin/raku

sub MAIN(
    $delimiters,
    $search
) {
    my @opening;
    my @closing;

    for $delimiters.comb.pairs -> $p {
        ($p.key %% 2 ?? @opening !! @closing).push($p.value);
    }

    ($search ~~ m:g/@opening/).join.say;
    ($search ~~ m:g/@closing/).join.say;
}