#!/usr/bin/env raku

use Test;
plan 9;

ok max-points(((1,1), (2,2), (3,3)))                             == 3;
ok max-points(((1,1), (2,2), (3,1), (1,3), (5,3)))               == 3;
ok max-points(((1,4),))                                          == 1;
ok max-points(((1,4), (2,2)))                                    == 2;
ok max-points(((0,0), (0,1), (0,2), (0,3), (0,4), (1,2), (1,3))) == 5;
ok max-points(((0,2), (1,2), (2,2), (4,5), (5,5), (8,8), (9,9))) == 4;
ok max-points(((1,4), (2,3), (3,2), (4,1), (5,2), (6,3), (7,4))) == 4;
ok max-points(((0,0), (1,1), (0,1), (2,3), (4,5), (6,7), (8,9))) == 5; 
ok max-points(((0,0), (1,1), (1,0), (3,2), (5,4), (7,6), (9,8))) == 5; 

sub max-points($points) {
    return $points if $points < 3;

    my $max;

    $max = max $max, .map(|*).Array.Bag.maxpairs.head.value
           for $points.combinations(2).classify(&slope).values; 

    sub slope($points) {
        my $m = (.[1;1]-.[0;1]) / (.[1;0]-.[0;0]) given $points;
        try { return $m.gist; CATCH { default { return Inf } } }
    }
    
    $max + 1;
}
