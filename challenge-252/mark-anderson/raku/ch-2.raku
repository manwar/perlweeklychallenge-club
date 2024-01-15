#!/usr/bin/env raku
use Test;

is-deeply uniq-sum-zero(5), (-2,-1,1,2,0);
is-deeply uniq-sum-zero(3), (-1,1,0);
is-deeply uniq-sum-zero(1), (0,);
is-deeply uniq-sum-zero(0), ();
is-deeply uniq-sum-zero(8), (-4,-3,-2,-1,1,2,3,4);
is-deeply uniq-sum-zero(9), (-4,-3,-2,-1,1,2,3,4,0);

multi uniq-sum-zero($n where 0)     { ()   }
multi uniq-sum-zero($n where 1)     { (0,) }
multi uniq-sum-zero($n where * > 1)
{
    my $i = $n div 2;
    (-$i,-$i+1...-1,1,2,3...$i,0)[^$n]
}
