#!/usr/bin/raku

sub MAIN(
    Int $base
) {
    my $max = 0;

    for 1 .. ∞ -> $n {
        my $square = ($n²).base($base);

        if $square.chars > $base {
            last;
        } 

        my @digits = $square.comb;

        if @digits == @digits.unique {
            $max = $square;
        }
    }

    say $max;
}