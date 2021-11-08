#!/usr/bin/raku

sub MAIN(
    Int $N #= an integer
) {
    my $n = $N.base(2);
    if $n.chars !%% 8 {
        $n = 0 x (8 - $n.chars % 8) ~ $n;
    }

    $n.comb(2).map({ $_.flip }).join.parse-base(2).say;
}