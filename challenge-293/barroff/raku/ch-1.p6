#!/usr/bin/env raku

sub similar-dominos(@dominos --> Int) {
    my $sorted-dominos = map({ $_.sort.join }, @dominos).Bag;
    $sorted-dominos{
        grep(
            { $sorted-dominos{$_} > 1 },
            $sorted-dominos.keys
        )
    }.sum;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 2;

    is similar-dominos([[1, 3], [3, 1], [2, 4], [6, 8]]), 2,
        'Works for ([[1, 3], [3, 1], [2, 4], [6, 8]])';
    is similar-dominos([[1, 2], [2, 1], [1, 1], [1, 2], [2, 2]]), 3,
        'Works for ([[1, 2], [2, 1], [1, 1], [1, 2], [2, 2]])';
}

#| Take user provided list like 1 1 2 2 2 3
multi sub MAIN(*@ints where @ints.elems mod 2 == 0) {
    my @dominos = map({ @ints[2*$_..2*$_+1] }, 0..@ints.elems ÷ 2 - 1);
    say similar-dominos(@dominos);
}
