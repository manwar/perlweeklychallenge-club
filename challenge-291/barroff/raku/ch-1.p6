#!/usr/bin/env raku

sub is-middle(@ints, Int $index --> Bool) {
    return @ints[1..*-1].sum == 0 if $index == 0;
    return @ints[0..*-2].sum == 0 if $index == @ints.elems - 1;
    return @ints[0..$index - 1].sum == @ints[$index+1..*-1].sum;
}

sub middle-index(@ints --> Int) {
    my &current-middle = &is-middle.assuming(@ints, *);
    my @res = map(&current-middle, 0 .. @ints.elems);
    my $middle = (0 .. @ints.elems - 1).first: &current-middle, :k;
    return $middle.defined ?? $middle !! -1;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 4;

    is middle-index([2, 3, -1, 8, 4]), 3, 'Works for (2, 3, -1, 8, 4)';
    is middle-index([1, -1, 4]), 2, 'Works for (1, -1, 4)';
    is middle-index([2, 5]), -1, 'Works for (2, 5)';
    is middle-index([8, -1, 1]), 0, 'Works for (8, -1, 1)';
}

#| Take user provided list like 1 1 2 2 2 3
multi sub MAIN(*@ints) {
    say middle-index(@ints);
}
