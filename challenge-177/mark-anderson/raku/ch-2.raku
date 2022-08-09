#!/usr/bin/env raku
use Test;

# A136098
is-deeply palindromic-prime-cyclops.head(20), (101, 
                                               16061, 
                                               31013, 
                                               35053, 
                                               38083, 
                                               73037, 
                                               74047, 
                                               91019, 
                                               94049, 
                                               1120211, 
                                               1150511, 
                                               1160611, 
                                               1180811, 
                                               1190911, 
                                               1250521, 
                                               1280821, 
                                               1360631, 
                                               1390931, 
                                               1490941, 
                                               1520251);

# Takes about 18 seconds on my computer.
is palindromic-prime-cyclops[9999], 3_446_840_486_443; 

sub palindromic-prime-cyclops 
{
    palindromic-cyclops.hyper.grep(&is-prime)
}

sub palindromic-cyclops 
{
    my @a = (1..9) xx *;

    gather
    {
        .take for 0, 101...909;

        loop
        {
            for [X] @a.head(2 + $++)
            {
                take +(.join ~ 0 ~ .join.flip)
            }
        }
    }
}
