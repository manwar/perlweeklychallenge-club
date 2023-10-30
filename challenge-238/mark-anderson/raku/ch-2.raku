#!/usr/bin/env raku
use Test;

is        persistence(277777788888899), 11; 
is-deeply persistence(39,999,4,9876),   (4,9876,39,999);
is-deeply persistence(1,27,90),         (1,90,27);
is-deeply persistence(868,769,976,679), (679,769,868,976);
is-deeply persistence(15,99,1,34),      (1,15,34,99);
is-deeply persistence(50,25,33,22),     (22,33,50,25);

multi persistence(+@a)
{
    @a.sort: { persistence($_), $_ } 
}

multi persistence($_ is copy) 
{
    sum do while .chars > 1 { $_ = [*] .comb; 1 }
}
