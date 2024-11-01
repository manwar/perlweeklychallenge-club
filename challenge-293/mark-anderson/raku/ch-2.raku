#!/usr/bin/env raku
use Test;

ok  boomerang([1,1], [2,3], [3,2]);
nok boomerang([1,1], [2,2], [3,3]);
ok  boomerang([1,1], [1,2], [2,3]);
nok boomerang([1,1], [1,2], [1,3]);
nok boomerang([1,1], [2,1], [3,1]);
ok  boomerang([0,0], [2,3], [4,5]);
nok boomerang([1,1], [1,1], [2,3]);

sub boomerang(+@points)
{
    return False unless @points.unique(:with(&[eqv])) == 3;
    my $m1 = do given @points { (.[0;1] - .[1;1]) / (.[0;0] - .[1;0]) } 
    my $m2 = do given @points { (.[0;1] - .[2;1]) / (.[0;0] - .[2;0]) }
    $m1 !== $m2 
}
