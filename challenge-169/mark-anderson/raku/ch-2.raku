#!/usr/bin/env raku

my $n = 1000000;

my $powerful = set gather
for 2..sqrt($n) -> $a
{
    for 1..* -> $b
    {
        my $c = $a**2 * $b**3;
        last if $c > $n;
        take $c;
    }
}

my $perfect = set gather 
for 2..sqrt($n) -> $a
{
    for 2..* -> $b
    {
        my $c = $a**$b;
        last if $c > $n;
        take $c;
    }
}

my $achilles = $powerful (-) $perfect;
my @achilles = $achilles.keys.sort;

say @achilles.head(20); # (72 108 200 288 392 432 500 648 675 800 864 968 972 1125 1152 1323 1352 1372 1568 1800)
say @achilles[900];     # 972000
