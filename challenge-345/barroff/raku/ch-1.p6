#!/usr/bin/env raku

use v6.d;

sub peak-positions(@ints --> Array:D) {
    my @prep = @ints[0] > @ints[1] ?? (0) !! ();
    my @appe = @ints[*-1] > @ints[*-2] ?? (@ints.elems - 1) !! ();
    my @result = grep(
        { @ints[$_] > @ints[$_ - 1] and @ints[$_] > @ints[$_ + 1] },
        1..@ints.elems - 2
    );
    @result.prepend(@prep).append(@appe);
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 5;

    is peak-positions([1, 3, 2]), (1), 'works for [1, 3, 2]';
    is peak-positions([2, 4, 6, 5, 3]), (2), 'works for [2, 4, 6, 5, 3]';
    is peak-positions([1, 2, 3, 2, 4, 1]), (2, 4), 'works for [1, 2, 3, 2, 4, 1]';
    is peak-positions([5, 3, 1]), (0), 'works for [5, 3, 1]';
    is peak-positions([1, 5, 1, 5, 1, 5, 1]), (1, 3, 5),
        'works for [1, 5, 1, 5, 1, 5, 1]';
}

#| Take user provided numbers 5 9 3 4 6
multi sub MAIN(*@ints) {
    say peak-positions(@ints);
}
