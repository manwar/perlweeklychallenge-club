#!/usr/bin/env raku

my $m = 8;
my $n = 2;

$m = 'N' x $m;
$n = 'N' x $n;

say +($m ~~ m:g/$n/);
