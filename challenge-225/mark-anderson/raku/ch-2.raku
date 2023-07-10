#!/usr/bin/env raku
use Test;

is-deeply left-right-sum-diff((10,4,8,3)),  (15,1,11,22);
is-deeply left-right-sum-diff((1)),         (0,);
is-deeply left-right-sum-diff((1,2,3,4,5)), (14,11,6,1,10);

sub left-right-sum-diff($list)
{
    my $left  =  [\+] (0, |$list[^(*-1)]);
    my $right = ([\+] (0, |$list.reverse[^(*-1)])).reverse;

    ($left >>-<< $right)>>.abs 
}
