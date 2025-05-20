#/usr/bin/env raku
use Test;

is-deeply rank-array(55,22,44,33), (4,1,3,2);
is-deeply rank-array(10,10,10),    (1,1,1);
is-deeply rank-array(5,1,1,4,3),   (4,1,1,3,2);

sub rank-array(+@ints)
{
    .{@ints} given [-Inf, |@ints].unique
                                 .sort
                                 .antipairs
                                 .Map
}
