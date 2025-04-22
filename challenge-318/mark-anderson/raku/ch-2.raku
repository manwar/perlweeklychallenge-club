#!/usr/bin/env raku
use Test;

ok  reverse-equals((3,2,1,4), (1,2,3,4));
nok reverse-equals((1,3,4), (4,1,3));
ok  reverse-equals((2,), (2,));
ok  reverse-equals((1,8,429,3,68,47,5), (1,68,3,429,8,47,5));

sub reverse-equals(@a, @b)
{
    my @e = @a >>==<< @b;

    my $first = @e.first(*.not, :k) // return True;
    my $last  = @e.first(*.not, :k:end);

    @a[$first...$last] eqv @b[$last...$first]
}
