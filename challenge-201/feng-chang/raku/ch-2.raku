#!/bin/env raku

proto penny-piles(UInt:D $n, Int:D $lower-bound where $lower-bound > 0 = 1) { * }

multi penny-piles($n)  { penny-piles($n, 1) }

multi penny-piles($n, $m where $m >  $n) { [] }
multi penny-piles($n, $m where $m == $n) { [[$n],] }

multi penny-piles($n, $lower-bound) {
    my @a;

    for $lower-bound .. $n-1 -> $i {
        @a.push(|penny-piles($n - $i, $i).map({ [ $i, |$_ ] }));
    }

    @a.push([$n]);

    @a
}

multi MAIN('test') {
    use Test;

    is-deeply penny-piles(1, 1), [[1],], 'penny-piles(1, 1) => [[1],]';
    is-deeply penny-piles(2, 2), [[2],], 'penny-piles(2, 2) => [[2],]';
    is-deeply penny-piles(5, 5), [[5],], 'penny-piles(5, 5) => [[5],]';

    is-deeply penny-piles(1), [[1],], 'penny-piles(1) => [[1],]';

    is-deeply penny-piles(2, 1), [[1, 1], [2]], 'penny-piles(2, 1) => [[1, 1], [2]]';
    is-deeply penny-piles(2), [[1, 1], [2]], 'penny-piles(2) => [[1, 1], [2]]';

    is-deeply penny-piles(3, 1), [[1, 1, 1], [1, 2], [3]], 'penny-piles(3, 1) => [[1, 1, 1], [1, 2], [3]]';
    is-deeply penny-piles(3), [[1, 1, 1], [1, 2], [3]], 'penny-piles(3) => [[1, 1, 1], [1, 2], [3]]';

    is-deeply penny-piles(4), [[1, 1, 1, 1], [1, 1, 2], [1, 3], [2, 2], [4]], 'penny-piles(4) => [[1, 1, 1, 1], [1, 1, 2], [1, 3], [2, 2], [4]]';
    is-deeply penny-piles(5), [[1, 1, 1, 1, 1], [1, 1, 1, 2], [1, 1, 3], [1, 2, 2], [1, 4], [2, 3], [5]],
              'penny-piles(5) => [[1, 1, 1, 1, 1], [1, 1, 1, 2], [1, 1, 3], [1, 2, 2], [1, 4], [2, 3], [5]]';

    done-testing;
}

multi MAIN(UInt:D $n) {
    put penny-piles($n).elems;
}
