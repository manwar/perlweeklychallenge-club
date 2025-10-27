#!/usr/bin/env raku
use Test;

is-deeply peak-positions([<1 3 2>]),         (1,);
is-deeply peak-positions([<2 4 6 5 3>]),     (2,);
is-deeply peak-positions([<1 2 3 2 4 1>]),   (2,4);
is-deeply peak-positions([<5 3 1>]),         (0,);
is-deeply peak-positions([<1 5 1 5 1 5 1>]), (1,3,5);

my @arr = (^100).roll(1000);
is-deeply peak-positions(@arr), peak-positions-alternate(@arr);

sub peak-positions(@ints)
{
    @ints.unshift(0);
    @ints.push(0);
    
    @ints.pairs
         .rotor(3 => -2)
         .grep({ .[0].value < .[1].value > .[2].value })
         .map( { .[0].key })
}

sub peak-positions-alternate(@ints)
{
    my @histogram;

    @ints.kv.map(-> $k,$v { @histogram[$k] = flat 'x' xx $v, 
                                                  ' ' xx @ints.max - $v });

    @histogram  = [Z] @histogram;
    @histogram .= map(*.Array);

    .sort given gather for @histogram -> @row
    {
        last if @row.none eq 'x';

        if @row.join ~~ m:g/<< x >>/ -> @m
        {
            for @m    
            {
                take .from - 1;
                @histogram[*;.from] = ' ' xx *  
            }
        }
    }
}
