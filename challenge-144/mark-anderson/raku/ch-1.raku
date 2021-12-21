#!/usr/bin/env raku

use Prime::Factor;
use Test;

is-deeply (^100).grep(&semi-prime), ( 4,  6,  9, 10, 14, 15, 21, 22, 25, 26, 
                                     33, 34, 35, 38, 39, 46, 49, 51, 55, 57, 
                                     58, 62, 65, 69, 74, 77, 82, 85, 86, 87, 
                                     91, 93, 94, 95); 

is-deeply (^Inf).hyper.grep(&semi-prime)[1000, 2000, 5000, 9999], 
                                        (3599, 7454, 19645, 40882);

sub semi-prime($n)
{
    return True if sqrt($n).is-prime;

    given proper-divisors($n).grep(*.is-prime)
    {
        return False if .elems !== 2;
        return .[0] * .[1] == $n;
    }
}
