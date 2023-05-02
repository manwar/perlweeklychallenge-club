#!/usr/bin/env raku

use v6.d;

sub get-position(Int @numbers, Int $n --> Int) {
    @numbers.keys.first({ @numbers[$_] == $n }) + 1;
}

sub replace-position(Int $position) {
    given $position {
        when 1 { return 'G' }
        when 2 { return 'S' }
        when 3 { return 'B' }
        default { return $position }
    }
}

sub rank-score(Int @numbers --> List) {
    my Int @sorted-numbers = sort(@numbers).reverse;
    my @ranks = map({ get-position(@sorted-numbers, $_) }, @numbers);
    return map( &replace-position, @ranks).list;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 4;

    is rank-score(Array[Int].new(1,2,4,3,5)), (5,4,'S','B','G'), 'works for (1,2,4,3,5)';
    is rank-score(Array[Int].new(8,5,6,7,4)), ('G',4,'B','S',5), 'works for (8,5,6,7,4)';
    is rank-score(Array[Int].new(3,5,4,2)), ('B','G','S',4), 'works for (3,5,4,2)';
    is rank-score(Array[Int].new(2,5,2,1,7,5,1)), (4,'S',4,6,'G','S',6), 'works for (2,5,2,1,7,5,1)';
}

#| Take user provided list like 1 2 2 3
multi sub MAIN(*@elements where @elements.elems ≥ 1 && all(@elements) ~~ /^<[+]>?<[0..9]>+$/) {
    my Int @int_elements = @elements;
    say rank-score(@int_elements);
}
