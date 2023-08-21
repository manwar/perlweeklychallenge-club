#!/usr/bin/env raku
use Test;

is count-words(<pay attention practice attend>, 'at'), 2;
is count-words(<janet julia java javascript>,   'ja'), 3;

sub count-words(@words, $prefix)
{
    @words.grep({ .starts-with($prefix) }).elems
}
