#!/usr/bin/env raku

#
# With help from the solutions by Luca and E Choroba.
#

use Test;
plan 2;

is nth-root(5, 248832), 12;
is nth-root(5, 34),     2.02;

sub nth-root($n, $k) 
{
   $k.roots($n).first.fmt("%.2f") + 0;
}
