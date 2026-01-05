#!/usr/bin/env raku
use Test;

nok mountain-array(<1 2 3 4 5>);
ok  mountain-array(<0 2 4 6 4 2 0>);
nok mountain-array(<5 4 3 2 1>);
nok mountain-array(<1 3 5 5 4 2>);
ok  mountain-array(<1 3 2>);

sub mountain-array(@i)
{
    my $k = @i.max(:k).head;
    return False if $k == 0|@i.end;
    return all ([<] @i.head($k+1)), ([>] @i.tail(@i-$k))
}
