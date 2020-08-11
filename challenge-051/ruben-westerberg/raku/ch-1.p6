#!/usr/bin/env raku

my @list=(-25, -10, -7, -3, 2, 4, 8, 10);
my $target=0;
@list.combinations.grep({.elems==3})==>
grep({.[0] <= .[1] <= .[2]})==>
grep({ ([+] $_ )==$target})==>
my @triplets;
for @triplets { printf "3 Sum triplet: %s+%s+%s=%s\n", @$_,$target};
