#!/usr/bin/env raku
use Test;

is-deeply final-price(8,4,6,2,3), (4,2,4,2,3);
is-deeply final-price(1,2,3,4,5), (1,2,3,4,5);
is-deeply final-price(7,1,1,5),   (6,0,1,5);

sub final-price(+@prices)
{
    @prices.pairs
           .map({ quietly .value - @prices[.key+1..*]
                          .first(* <= .value) 
                })
}
