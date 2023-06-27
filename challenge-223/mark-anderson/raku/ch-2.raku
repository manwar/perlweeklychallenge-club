#!/usr/bin/env raku
use Adverb::Eject;
use Test;

is box-coins([3,1,5,8]), 167;
is box-coins([1,5]),      10;

sub box-coins(@a, $total is copy = 0)
{
    return $total unless @a;
    my $k;

    if @a.elems < 3 
    {
        $k = @a.antipairs.min.value;
        $total += [*] @a
    }

    else
    {
        $k = @a[1..*-2].antipairs.min.value.succ;
        $total += [*] @a[$k.pred, $k, $k.succ]
    }

    @a[$k]:eject;
    box-coins(@a, $total)
}
