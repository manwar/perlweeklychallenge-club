#!/usr/bin/env raku
use Test;

is equal-strings(<abc abb ab>),                          2;
is equal-strings(<ayz cyz xyz>),                        -1;
is equal-strings(<yza yzb yzc>),                         3;
is equal-strings(<yzabe yzabcd>),                        3;
is equal-strings(<yzc yzab yzab yza yza yzabx yzabde>), 14; 
is equal-strings(<yza>),                                 0;

multi equal-strings(+@s where 0|1) { 0 }

multi equal-strings(+@s)
{
    my @a = [Z] @s>>.comb;
    my $i = @a.first({ not [eq] .flat }, :k) // @a.elems; 
    $i || return -1;
    [+] @s.map({ .chars - $i }) 
}
