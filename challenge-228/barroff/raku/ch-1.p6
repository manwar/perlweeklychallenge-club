#!/usr/bin/env raku

use v6.d;

sub unique-sum(Int:D @ints --> Int:D) {
    my Bag $int-bag = Bag(@ints);
    sum(grep { $int-bag{$_} == 1 }, keys $int-bag);
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is unique-sum(Array[Int:D].new(2, 1, 3, 2)),  4, 'works for (2, 1, 3, 2)';
    is unique-sum(Array[Int:D].new(1, 1, 1, 1)),  0, 'works for (1, 1, 1, 1)';
    is unique-sum(Array[Int:D].new(2, 1, 3, 4)), 10, 'works for (2, 1, 3, 4)';
}

#| Take user provided year like 2023
multi sub MAIN(Int:D @numbers) {
    my Int @int-numbers = @numbers;
    say unique-sum(@int-numbers);
}

