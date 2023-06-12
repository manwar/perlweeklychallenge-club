#!/usr/bin/env raku

use v6.d;

sub is-perfect-square(Int $number --> Bool) {
    return sqrt($number).narrow.^name eq 'Int';
}

sub check-permutation(@perm --> Bool) {
    return so all(map({ is-perfect-square(@perm[$_] + @perm[$_ + 1] ) }, 0 .. @perm.elems - 2));
}

sub squareful(Int:D @numbers --> List) {
    my @perms = unique(permutations(@numbers), with => &[~~]);
    List( grep( &check-permutation, @perms ) );
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 2;

    is squareful(Array[Int:D].new(1, 17, 8)), [ (1, 8, 17), (17, 8, 1) ],
        'works for (1, 17, 8)';
    is squareful(Array[Int:D].new(2, 2, 2)), [(2, 2, 2)],
        'works for (2, 2, 2)';
}

#| Take user provided list like 1 17 8
multi sub MAIN(*@numbers where @numbers.elems ≥ 1) {
    my Int @int-nums = @numbers;
    say squareful(@int-nums);
}
