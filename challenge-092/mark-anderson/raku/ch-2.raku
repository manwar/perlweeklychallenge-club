#!/usr/bin/env raku

use Test;
plan 9;

is-deeply insert-interval((2,6),   ((1,4),(8,10))),       ((1,6),(8,10));
is-deeply insert-interval((5,8),   ((1,2),(3,7),(8,10))), ((1,2), (3,10));
is-deeply insert-interval((10,11), ((1,5),(7,9))),        ((1,5),(7,9),(10,11));
is-deeply insert-interval((1,2),   ((3,4),(7,8))),        ((1,2),(3,4),(7,8));
is-deeply insert-interval((1,9),   ((2,3),(7,8))),        ((1,9),);
is-deeply insert-interval((3,5),   ((1,2),(6,9))),        ((1,2),(3,5),(6,9));
is-deeply insert-interval((4,5),   ((1,2),(3,6),(7,9))),  ((1,2),(3,6),(7,9));
is-deeply insert-interval((2,8),   ((1,2),(3,7),(8,10))), ((1,10),);
is-deeply insert-interval((2,5),   ((1,2),(3,7),(8,10))), ((1,7),(8,10));

sub insert-interval($N, @S) {
    return $N, |@S if $N[1] < @S[0;0];
    return |@S, $N if $N[0] > @S[*-1][1];

    my $h = @S.first({ $N[0] <= .[1] }, :k);
    my $t = @S.first({ $N[1] >= .[0] }, :k:end);

    my $head = min $N[0], @S[$h;0];
    my $tail = max $N[1], @S[$t;1];

    |@S[0..$h-1], ($head, $tail), |@S[$t+1..*];
}
