#!/usr/bin/env raku
use Test;
use Benchy;

is consistant-strings(<ad bd aaab baa badab>,     'ab'),  2;
is consistant-strings(<a b c ab ac bc abc>,       'ab'),  3;
is consistant-strings(<cc acd b ba bac bad ac d>, 'cad'), 4;
benchmark();

sub consistant-strings(@a, $allowed)
{
    @a.grep({ .comb (<=) $allowed.comb }).elems
}

sub consistant-strings-slow(@a, $allowed)
{
    @a.match(/ <|w> <{"<[$allowed]>"}>+ <|w> /, :global).elems
}

sub benchmark
{
    b 10,
    {   
        consistant-strings-slow(<ad bd aaab baa badab>,     'ab');
        consistant-strings-slow(<a b c ab ac bc abc>,       'ab');
        consistant-strings-slow(<cc acd b ba bac bad ac d>, 'cad') 
    },

    { 
        consistant-strings(<ad bd aaab baa badab>,     'ab');
        consistant-strings(<a b c ab ac bc abc>,       'ab');
        consistant-strings(<cc acd b ba bac bad ac d>, 'cad') 
    }

    # Bare: 0.000040891s
    # Old:  11.435895767s
    # New:  0.019084392s
    # NEW version is 599.23x faster
}
