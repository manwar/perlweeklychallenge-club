#!/usr/bin/env raku
use Adverb::Eject;
use Test;

is box-coins([3,1,5,8]), 167;
is box-coins([1,5]),      10;

multi box-coins(@a where .elems < 3, $total is copy = 0)
{
    return $total unless @a;

    my $k = @a.antipairs.min.value;

    $total += [*] @a;    
    @a[$k]:eject;
    box-coins(@a, $total)
}

multi box-coins(@a, $total is copy = 0)
{
    my $k = @a[1..*-2].antipairs.min.value.succ;

    $total += [*] @a[$k.pred], @a[$k], @a[$k.succ];    
    @a[$k]:eject;
    box-coins(@a, $total)
}    
