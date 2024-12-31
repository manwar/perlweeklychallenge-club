#!/usr/bin/env raku
use Test;

is step-by-step(-3,2,-3,4,2), 5;
is step-by-step(1,2),         1;
is step-by-step(1,-2,-3),     5;

sub step-by-step(+@ints)
{
    given min [\+] @ints  
    {
        $_ >= 1 ?? $_ !! .abs + 1
    }
}
