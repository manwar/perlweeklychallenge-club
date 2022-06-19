#!/usr/bin/env raku

# This program generates 10,000 Achilles numbers in under 2 seconds.

my \n = 90209312; # The 10,000th Achilles number from https://oeis.org/A052486/b052486.txt

my $powerful = set gather
{
    for 1..sqrt(n) -> $a
    {
        for 1..* -> $b
        {
            my $c = $a**2 * $b**3;
            last if $c > n;
            take $c;
        }
    }
}

my $perfect = set gather
{
    take 1;

    for 2..sqrt(n) -> $a
    {
        for 2..* -> $b
        {
            my $c = $a**$b;
            last if $c > n;
            take $c;
        }
    }
}

my $achilles = $powerful (-) $perfect;
my @achilles = $achilles.keys.sort;

say @achilles[^20];        # (72 108 200 288 392 432 500 648 675 800 864 968 972 1125 1152 1323 1352 1372 1568 1800)
say @achilles[9990..9999]; # (90025452 90048200 90100125 90101888 90117775 90124083 90124672 90140256 90155592 90209312)
