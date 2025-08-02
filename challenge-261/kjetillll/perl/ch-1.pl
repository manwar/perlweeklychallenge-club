use strict; use warnings;

sub sumdiff {
    eval( join '+', @_ )
    -
    eval( join '+', "@_" =~ /\d/g )
}



#========== Test ========================================
use Test::More tests => 4;
is( sumdiff( @{ $$_{input} } ), $$_{output} ) for
    {
        input=> [1,2,3,45],
        output=> 36
    },
    {
        input=> [1,12,3],
        output=> 9
    },
    {
        input=> [1,2,3,4],
        output=> 0
    },
    {
        input=> [236, 416, 336, 350],
        output=> 1296
    };
