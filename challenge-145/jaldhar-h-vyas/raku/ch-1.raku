#!/usr/bin/raku

my @a = (1, 2, 3);
my @b = (4, 5, 6);

say  [+] (@a Z @b).map({ [*] $_; });