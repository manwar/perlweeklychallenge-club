#!/usr/bin/env raku

use v6.d;

sub consecutive-sequence(@ints --> Int) {
    my ($minimum, $maximum) = @ints.minmax.minmax;
    my Bool @spots[$maximum + 1 - $minimum];
    @spots[0..@spots.elems - 1] = (loop { False });
    map({ @spots[$_ - $minimum] = True }, @ints);
    my Int $longest-seq = 1;
    my Int $current-seq = 0;
    for @spots {
        if $_ {
            $current-seq++;
        } elsif $current-seq ≠ 0 {
            $longest-seq = max($current-seq, $longest-seq);
            $current-seq = 0;
        }
    }
    $longest-seq = max($longest-seq, $current-seq);
    return $longest-seq == 1 ?? -1 !! $longest-seq;


}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is consecutive-sequence([10, 4, 20, 1, 3, 2]), 4,
        'Works for ([10, 4, 20, 1, 3, 2])';
    is consecutive-sequence([0, 6, 1, 8, 5, 2, 4, 3, 0, 7]), 9,
        'Works for ([0, 6, 1, 8, 5, 2, 4, 3, 0, 7])';
    is consecutive-sequence([10, 20, 30]), -1, 'Works for ([10, 20, 30])';
}

#| Take user provided list like 1 1 2 2 2 3
multi sub MAIN(*@ints) {
    say consecutive-sequence(@ints);
}

