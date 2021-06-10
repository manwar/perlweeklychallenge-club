#!/usr/bin/raku

sub MAIN(
    Int $N, #= numerator
    Int $D where {$D != 0 } #= denominator (not 0)
) {
    my ($non-rep, $repeating) = ($N / $D).base-repeating;
    if $repeating ne q{} {
        $repeating = "($repeating)";
    }
    say "$non-rep$repeating";
}