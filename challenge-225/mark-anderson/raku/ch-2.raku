#!/usr/bin/env raku
use Test;

is-deeply left-right-sum-diff((10,4,8,3)),  (15,1,11,22);
is-deeply left-right-sum-diff((1)),         (0,);
is-deeply left-right-sum-diff((1,2,3,4,5)), (14,11,6,1,10);

sub left-right-sum-diff($n)
{
    my $list = (0, |$n, 0);

    my $left  =  [\+] $list[^(*-2)];
    my $right = ([\+] $list[$list.end...2]).reverse;

    ($left >>-<< $right)>>.abs 
}
