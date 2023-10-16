#!/usr/bin/env raku
use Test;
use Benchy;

is consistent-strings(<ad bd aaab baa badab>,     'ab'),  2;
is consistent-strings(<a b c ab ac bc abc>,       'abc'), 7;
is consistent-strings(<cc acd b ba bac bad ac d>, 'cad'), 4;
benchmark();

sub consistent-strings(@a, $allowed)
{
    @a.grep({ .comb (<=) $allowed.comb }).elems
}

sub consistent-strings-slow(@a, $allowed)
{
    @a.match(/ <|w> <{"<[$allowed]>"}>+ <|w> /, :global).elems
}

sub benchmark
{
    b 10,
    {   
        consistent-strings-slow(<ad bd aaab baa badab>,     'ab');
        consistent-strings-slow(<a b c ab ac bc abc>,       'abc');
        consistent-strings-slow(<cc acd b ba bac bad ac d>, 'cad') 
    },

    { 
        consistent-strings(<ad bd aaab baa badab>,     'ab');
        consistent-strings(<a b c ab ac bc abc>,       'abc');
        consistent-strings(<cc acd b ba bac bad ac d>, 'cad') 
    }

    # Bare: 0.000040891s
    # Old:  11.435895767s
    # New:  0.019084392s
    # NEW version is 599.23x faster
}
