#!/usr/bin/env raku
use Test;

is arrange-boxes([1,3], [3,5], [6,8], [2,4]),                     4;
is arrange-boxes([4,5], [4,6], [6,7], [2,3], [4,3]),              3;
is arrange-boxes([5,5], [5,5], [5,5]),                            1;
is arrange-boxes([2,100], [3,200], [4,300], [5,50], [5,400]),     4;
is arrange-boxes([10,20], [15,10], [20,30], [12,18], [16,25]),    3;

is arrange-boxes([1,3], [3,5], [6,8], [2,4],
                 [4,5], [4,6], [6,7], [2,3], [4,3],
                 [5,5], [5,5], [5,5],
                 [2,100], [3,200], [4,300], [5,50], [5,400],
                 [10,20], [15,10], [20,30], [12,18], [16,25]),    8;

# E Choroba tests
is arrange-boxes([10,20], [15,10], [20,30], [16,18], [17,25]),    4;
is arrange-boxes([8,4], [19,17], [1,9], [11,5], [12,18], [13,6]), 4;
is arrange-boxes([27,16], [5,15],  [51,83], [62,82], [79,46], 
                 [63,73], [74,74], [8,39],  [87,22], [16,41], 
                 [84,86], [77,76], [26,58], [52,9]),              8;

# David Smith tests
is arrange-boxes($[1,1],),                                        1;
is arrange-boxes([1,1], [1,1]),                                   1;
is arrange-boxes([2,1], [1,1]),                                   1;
is arrange-boxes([1,1], [2,2]),                                   2;
is arrange-boxes([1,5], [2,3], [3,3]),                            1;
is arrange-boxes([1,5], [2,2], [3,3]),                            2;
is arrange-boxes([1,1], [2,3], [3,3]),                            2;
is arrange-boxes([1,1], [2,4], [3,3]),                            2;

# Bob Lied test
is arrange-boxes([10,10], [9,1], [5,5], [4,4], [3,3]),            4;

say arrange-boxes((1..100).roll(2000).batch(2));
 
sub arrange-boxes(+@boxes)
{
    my %graph = do for @boxes -> ($h,$t)
    {
        "$h $t" => [ @boxes.grep: { .head > $h and .tail > $t } ]
    }

    %graph .= classify: { .value.elems }

    my %seen;
    %seen{ (%graph{0}:delete)>>.key } = 1 xx *;

    for %graph.sort(*.key.Int)
    {
        for .value.flat -> $p 
        {
            for $p.value.flat -> $v 
            {
                %seen{$p.key} = max %seen{$p.key}, %seen{$v} + 1
            }
        }
    }        

    %seen.values.max
}
