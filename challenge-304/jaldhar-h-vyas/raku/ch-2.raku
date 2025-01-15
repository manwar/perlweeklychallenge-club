#!/usr/bin/raku

sub MAIN(
    $n,
    *@ints
) {
    my $maxAverage = 0;

    for 0 .. @ints.elems - $n -> $i {
        my $average = @ints[$i ..^ $i + $n].sum / $n;
        if $average > $maxAverage {
            $maxAverage = $average;
        }
    }

    say $maxAverage;
}