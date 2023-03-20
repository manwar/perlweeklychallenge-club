#!/usr/bin/env raku

use v6.d;

sub get-duplicate(Int @numbers --> Int) {
    my %number-bag = Bag(@numbers);
    my $multiples = grep({ %number-bag{$_} > 1 }, %number-bag.keys);
    $multiples.elems == 1 ?? Int($multiples[0]) !! -1;
}

sub get-missing(Int @numbers --> Int) {
    my $set-difference = Set(@numbers[0] .. @numbers[* - 1]) (-) Set(@numbers);
    given $set-difference.elems {
        when 0 { return @numbers[* - 1] + 1 }
        when 1 { return $set-difference.keys[0] }
        default { return -1 }
    }
}

sub duplicate-and-missing(Int @numbers) {
    my Int @dam = (get-duplicate(@numbers), get-missing(@numbers));
    -1 (elem) @dam ?? -1 !! @dam;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is duplicate-and-missing(Array[Int].new([1, 2, 2, 4])),
        (2, 3),
        "works for (1, 2, 2, 4)";
    is duplicate-and-missing(Array[Int].new([1, 2, 3, 4])),
        -1,
        "works for (1, 2, 3, 4)";
    is duplicate-and-missing(Array[Int].new([1, 2, 3, 3])),
        (3, 4),
        "works for (1, 2, 3, 3)";
}

#| Take user provided list like 1 2 2 3
multi sub MAIN(*@elements where @elements.elems ≥ 1 && all(@elements) ~~ /^0?<[1..9]><[0..9]>*$/) {
    my Int @int-elements = map({ $_.Int }, @elements);
    say "the result is { duplicate-and-missing(@int-elements) }"
}
