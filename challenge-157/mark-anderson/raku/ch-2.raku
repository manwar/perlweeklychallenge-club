#!/usr/bin/env raku

multi brazilian($n where * < 7)          { return False }

multi brazilian($n where * == 121)       { return True }

multi brazilian($n where not *.is-prime) { not $n.sqrt.is-prime } 

multi brazilian($n)
{
    for 2..$n.sqrt.floor -> $b
    {
        return True if (1, $b, $b**2, $b**3...$b**$n.log($b).floor).sum == $n 
    }

    return False
}
