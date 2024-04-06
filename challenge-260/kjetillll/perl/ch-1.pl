use List::Util uniq; use strict; use warnings;

sub f {
    my %count;
    $count{ $_ }++ for @_;
    0 + ( values %count == uniq values %count )
}



#========== Test ========================================
use Test::More tests=>3;
is( f( @{ $$_{input} } ), $$_{output} ) for
    {
        input  => [1,2,2,1,1,3],
        output => 1
    },
    {
        input => [1,2,3],
        output => 0
    },
    {
        input => [-2,0,1,-2,1,1,0,1,-2,9],
        output => 1
    };
