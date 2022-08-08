#!/usr/bin/raku

sub MAIN() {
    number: for 1 .. ∞ -> $n {
        my $nn = $n.comb.sort.join;

        for 2 .. 6 -> $i {
            next number unless ($i * $n).comb.sort.join == $nn;
        }

        say $n;
        last;
    }
}
