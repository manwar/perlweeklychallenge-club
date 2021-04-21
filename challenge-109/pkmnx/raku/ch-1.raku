#!/usr/bin/env raku


my $upr = 20;
my @chwla = (1 .. $upr).map(-> $n { (2..$n -1).grep({ !($n % $_) }).sum() });
@chwla.say;
