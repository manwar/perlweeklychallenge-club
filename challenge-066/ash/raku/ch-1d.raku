#!/usr/bin/env raku

my $m = -9;
my $n = -2;

$m = 'N' x $m.abs;
$n = 'N' x $n.abs;

print '-' if +($m ~ $n ~~ m:g/'-'/) == 1;
say +($m ~~ m:g/$n/);
