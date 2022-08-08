#!/usr/bin/raku

sub isReversible(Int $n) {
    return $n + $n.flip ~~ /^ <[13579]>+ $/;
}

sub MAIN() {
    my @reversibles;

    for 1 ..^ 100 -> $n {
        if isReversible($n) {
            @reversibles.push($n);
        }
    }

    @reversibles.join(q{, }).say;
}