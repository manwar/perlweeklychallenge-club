use List::Util reduce; use strict; use warnings;
sub cart{@{(reduce{[map{//;map[@$_,$'],@$a}@$b]}[[]],@_)}}

sub eq_div_count {
    my( $ints, $k ) = @_;
    0 + grep {
        my( $i, $j ) = @$_;
        0 <= $i                      and 
        $i < $j                      and
        $j < @$ints                  and
        $$ints[ $i ] == $$ints[ $j ] and
        ($i * $j) % $k == 0
    }
    cart( [ 0 .. @$ints-2],
          [ 0 .. @$ints-1] )
}

#========== Test ========================================
use Test::More; 
is( eq_div_count( @$_{'input','k'} ), $$_{output} ) for
    {
        input  => [ 3, 1, 2, 2, 2, 1, 3 ],
        k      => 2,
        output => 4
    },
    {
        input  => [ 1, 2, 3 ],
        k      => 1,
        output => 0
    };
done_testing;
