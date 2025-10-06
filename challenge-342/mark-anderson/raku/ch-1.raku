#!/usr/bin/env raku
use Test;

is balance-string("a0b1c2"),  "0a1b2c";
is balance-string("abc12"),   "a1b2c";
is balance-string("0a2b1c3"), "0a1b2c3";
is balance-string("1a23"),     Empty.Str;
is balance-string("ab123"),   "1a2b3"; 

sub balance-string($str)
{
    my %h = $str.comb.classify: { .match(/<digit>/) ?? 'digits' !! 'letters' }

    return Empty.Str if abs %h<digits> - %h<letters> > 1;
    
    %h<digits>  .= sort;
    %h<letters> .= sort;

    my @order = %h.values.sort: { -.elems, .[0].ord }

    [~] flat roundrobin @order>>.flat
}
