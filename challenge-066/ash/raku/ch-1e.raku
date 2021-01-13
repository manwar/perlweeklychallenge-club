#!/usr/bin/env raku

# can be both positive and negative numbers in any combination
my $m = -3;
my $n = 2;

print '-' if +($m ~ $n ~~ m:g/'-'/) == 1;
($m, $n)>>.=abs;
say ($m, $m - $n ... * < $n) - 1;
