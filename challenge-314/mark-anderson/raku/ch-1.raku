#!/usr/bin/env raku
use Test;

is equal-strings(<abc abb ab>),   2;
is equal-strings(<ayz cyz xyz>), -1;
is equal-strings(<yza yzb yzc>),  3;

sub equal-strings(+@s)
{
    my @a = [Z] @s>>.comb;
    my $i = @a.first({ not [eq] .flat }, :k) // @a.elems; 
    $i || return -1;
    return [+] @s.map({ .chars - $i }) 
}
