#! /usr/bin/env rakudo

my $N = 9;
my @p = gather for (2..^$N) { .take if .is-prime }
say @p.combinations.grep( {.sum == $N} ).sort( {$^a.elems > $^b.elems } ).first.elems
