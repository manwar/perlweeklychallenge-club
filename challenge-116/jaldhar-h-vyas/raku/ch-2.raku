#!/usr/bin/raku

sub MAIN(
    Int $N where { $N >= 10; } #= integer greater than 9
) {
    my @digits = $N.comb.map({ $_ * $_; });
    say ([+] @digits).sqrt %% 1 ?? 1 !! 0;
}