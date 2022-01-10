#!/usr/bin/env raku

say (2, 3, { $_ + 2 } ... *).grep(&tp).head(20);

multi tp(\n where *.index: 0)
{
    False;
}

multi tp(\n where * < 10)
{
    n.is-prime
}

multi tp(\n)
{
    return False unless n.is-prime;
    samewith(n.substr: 1);  
}
