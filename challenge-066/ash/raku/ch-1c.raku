#!/usr/bin/env raku

# can be both positive and negative numbers in any combination
my $m = 5;
my $n = -2;

print '-' if +($m ~ $n ~~ m:g/'-'/) == 1;
say ($m.abs, $m.abs - $n.abs ... * < $n.abs) - 1;

