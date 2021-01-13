#!/usr/bin/env raku

# positive only
my $m = 5;
my $n = 2;

say ($m, $m - $n ... * < $n) - 1;
