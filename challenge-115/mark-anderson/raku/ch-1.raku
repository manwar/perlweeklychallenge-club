#!/usr/bin/env raku

use Test;
plan 2;

is string-chain(<abc dea cd>),  1;
is string-chain(<ade cbd fgh>), 0;

sub string-chain(@words) 
{
    my $heads = bag @words.map(*.substr(0, 1));
    my $tails = bag @words.map(*.substr(*-1));

    +($heads eqv $tails)
}
