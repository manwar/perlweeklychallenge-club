#!/usr/bin/env raku

use Test;

ok brazilian(7);
ok brazilian(8);
ok brazilian(121);
ok brazilian(222);
ok brazilian(4618);

nok brazilian(6);
nok brazilian(17);
nok brazilian(547);
nok brazilian(3643);
nok brazilian(4603);

multi brazilian($n where * < 7)          { return False         }

multi brazilian($n where * == 121)       { return True          }

multi brazilian($n where not *.is-prime) { not $n.sqrt.is-prime } 

multi brazilian($n)
{
    for 2..$n.sqrt.floor -> $b
    {
        return True if (1, $b, $b**2, $b**3...$b**$n.log($b).floor).sum == $n 
    }

    return False
}
