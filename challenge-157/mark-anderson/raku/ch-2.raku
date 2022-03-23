#!/usr/bin/env raku

use Test;

for <7 13 31 43 73 127 157 211 241 307 421 463 601 757 1093 
     1123 1483 1723 2551 2801 2971 3307 3541 3907 4423>
{
    ok Brazilian($_), "$_ is a Brazilian prime"
}


for <23 89 131 181 389 541 557 599 659 997 1103 1459 1861 
     2417 2683 3167 3583 3797 3881 4261>
{
    nok Brazilian($_), "$_ is not a Brazilian prime"
}

for <8 121 265 326 404 674 749 884 1043 1648 1671 1710 1941 2168 
     2379 2674 2811 3028 3218 3345 3796 4030 4390 4453 4538>
{
    ok Brazilian($_), "$_ is a Brazilian composite"
}


for <4 6 9 25 49 169 289 361 529 841 961 1369 1681 1849 2209 
     2809 3481 3721 4489>
{
    nok Brazilian($_), "$_ is not a Brazilian composite"
}

multi Brazilian($n where * < 7)          { return False         }

multi Brazilian($n where * == 121)       { return True          }

multi Brazilian($n where not *.is-prime) { not $n.sqrt.is-prime } 

multi Brazilian($n)
{
    for $n.sqrt.floor...2 -> $b
    {
        return True if (1, $b, $b**2, $b**3...$b**$n.log($b).floor).sum == $n 
    }

    return False
}
