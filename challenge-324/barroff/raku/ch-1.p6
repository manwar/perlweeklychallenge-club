#!/usr/bin/env raku

use v6.d;

sub d2-array(Int $r, Int $c, @ints --> Seq) {
    map({ @ints[$_ × $c ..^ ($_ + 1) × $c] }, 0..^$r);
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is d2-array(2, 2, [1, 2, 3, 4]), [[1, 2], [3, 4]],
        'works for "2, 2, [1, 2, 3, 4]"';
    is d2-array(1, 3, [1, 2, 3]), [1, 2, 3], 'works for "1, 3, [1, 2, 3]"';
    is d2-array(4, 1, [1, 2, 3, 4]), [[1], [2], [3], [4]],
        'works for "4, 1, [1, 2, 3, 4]"';
}

#| Take user provided number like "Perl Weekly Challenge" l a
multi sub MAIN(Int $r, Int $c, *@ints) {
    say d2-array($r, $c, @ints);
}
