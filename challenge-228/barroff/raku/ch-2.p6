#!/usr/bin/env raku

use v6.d;

sub empty-array-private(@ints, @sorted-ints --> Int:D) {
    return 1 if @ints.elems <= 1;
    my $index = @ints.first: * == @sorted-ints[0], :k;
    my @new-ints = $index == @ints.elems ?? [] !! @ints[$index+1..*-1];
    return 1 + $index + empty-array-private(
        @new-ints.append(@ints[0..$index - 1]),
        @sorted-ints[1..*-1]
    );
}

sub empty-array(@ints --> Int:D) {
    return 0 if @ints.elems == 0;
    my @sorted-ints = sort(@ints);
    return empty-array-private(@ints, @sorted-ints);
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is empty-array((3, 4, 2)),  5, 'works for (3, 4, 2)';
    is empty-array((1, 2, 3)),  3, 'works for (1, 2, 3)';
    is empty-array((2, 1, 3)),  5, 'works for (2, 1, 3)';
}

#| Take user provided list like 1 2 3
multi sub MAIN(*@numbers where @numbers.elems ≥ 1) {
    say empty-array(@numbers);
}

