#!/usr/bin/env raku
use Test;

is complete-day([12,12,30,24,24]), 2;
is complete-day([72,48,24,5]),     3;
is complete-day([12,18,24]),       0;

sub complete-day(@hours)
{
    @hours.combinations(2)
          .grep({ .sum %% 24 }) 
          .elems
}
