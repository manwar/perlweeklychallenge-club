#!/usr/bin/env perl6

# ch-1.p6 - Merge intervals
#
# Ryan Thompson <rjt@cpan.org>

sub merge-int( **@int ) {
    reduce -> $res, $e {
        ($res.tail and $res.tail.tail ≥ $e.head) ??
            ($res.tail.tail = $e.tail) !! $res.push: $e;
        $res
     }, [], |@int.sort: { .head };
}

say merge-int([2,7], [3,9], [10,12], [15,19], [18,22]);

use Test;

is-deeply 
    merge-int([2,7], [3,9], [10,12], [15,19], [18,22]), 
    [ [2, 9], [10, 12], [15, 22] ], 'PWC example';

is-deeply 
    merge-int([10,12], [18,22], [2,7], [15,19], [3,9]), 
    [ [2, 9], [10, 12], [15, 22] ], 'PWC example, unsorted';

done-testing;
