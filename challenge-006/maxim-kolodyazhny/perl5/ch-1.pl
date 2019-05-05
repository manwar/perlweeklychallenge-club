#!/usr/bin/env perl -p

# echo 1,2,3,4,42,43,45 | ch-1.pl

use 5.028.1;
use List::Util qw(sum);

s{
    ( \b \d+   )
    ( ,? \d+ , )+
    (    \d++  )
    (??{
        # this block is treated as a pattern
        # != will return '' (match) or 1 (fail, because \d++ will swallow all)
        # sum( eval $& ) will work too (;
        ( $3 - $1 + 1 ) * ( $1 + $3 ) / 2 != ( sum( split ',', $& ) || -1 );
    })
}
{$1-$3}xg;
