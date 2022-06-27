#!/usr/bin/env raku

say (^10).map(&primorial);

sub primorial(\n)
{
    [*] (2,3,5,7...*).grep(&is-prime).head(n);
}
