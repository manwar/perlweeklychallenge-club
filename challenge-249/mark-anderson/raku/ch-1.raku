#!/usr/bin/env raku
use Test;

is-deeply equal-pairs(3,2,3,2,2,2), ((2,2),(2,2),(3,3));
is-deeply equal-pairs(1,2,3,4),     ();

sub equal-pairs(+@a where * %% 2)
{
    my $b = @a.Bag;
    return () unless all($b.values) %% 2;
    $b.kxxv.batch(2).sort
}
