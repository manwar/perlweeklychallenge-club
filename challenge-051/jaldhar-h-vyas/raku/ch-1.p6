#!/usr/bin/perl6

multi sub MAIN($T, *@L) {
 
    for @L.combinations(3) -> @combo {
        my @triplet = @combo.sort;

        my $total = [+] @triplet;

        if ($total == $T) {
            @triplet.join(q{ }).say;
        }
    }
}