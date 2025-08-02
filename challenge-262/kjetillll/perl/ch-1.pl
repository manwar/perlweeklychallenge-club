use strict; use warnings;

sub max_pos_neg {
    my @count = (0,0);
    $count[ $_ >= 0 ]++ for @_;
    $count[ $count[0] < $count[1] ];
}

#========== Test ========================================
use Test::More; 
is( max_pos_neg( @{ $$_{input} } ), $$_{output} )
    for
    {
        input  => [-3, 1, 2, -1, 3, -2, 4],
        output => 4
    },
    {
        input  => [-1, -2, -3, 1],
        output => 3
    },
    {
        input  => [1,2],
        output => 2
    };
done_testing;
