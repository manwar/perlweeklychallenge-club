#!/usr/bin/env raku

#| Run Test Suite
multi sub MAIN('test') {
    use Test;
    is concat-number(6, 12, 25, 1), 1286;
    is concat-number(10, 7, 31, 5, 2, 2), 489;
    is concat-number(1, 2, 10), 112;
    done-testing;
}

#| Print the concatentaion number
multi sub MAIN(
    *@vals where all(@vals) ~~ IntStr #= List of ints
) {
    concat-number( |@vals ).say;
}

sub concat-number( *@vals ) {
    my $total = 0;
    while (@vals.elems > 1) {
        my $f = @vals.shift;
        my $l = @vals.pop;
        $total += ($f ~ $l);
    }
    $total += @vals[0] if @vals.elems == 1;
    return $total;
}
