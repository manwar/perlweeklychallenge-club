#!/usr/bin/env raku
use Test;

is-deeply finishing-order((3,1,4,2,5),   (1,2,4)),   (1,4,2);
is-deeply finishing-order((5,4,3,2,1),   (1,3,5)),   (5,3,1);
is-deeply finishing-order((2,4,1,3),     (1,2,3,4)), (2,4,1,3);
is-deeply finishing-order((4,1,3,2),     (3,)),      (3,);
is-deeply finishing-order((1,3,2,6,5,4), (1,2,3)),   (1,3,2);

sub finishing-order(@order, @friends)
{
    @order.grep(@friends.any)
}
