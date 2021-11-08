#!/usr/bin/raku

sub MAIN(Int $N) {
    my $rightmostOneBit = $N +& -$N;
    my $nextHigherOneBit = $N + $rightmostOneBit;
    my $rightOnesSequence = $N +^ $nextHigherOneBit;

    $rightOnesSequence /= $rightmostOneBit;
    $rightOnesSequence +>= 2;

    say $nextHigherOneBit +| $rightOnesSequence;
}