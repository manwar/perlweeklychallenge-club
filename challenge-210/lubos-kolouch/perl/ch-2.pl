use strict;
use warnings;
use Test::More;

sub number_collision {
    my @list     = @_;
    my @positive = sort { $a <=> $b } grep { $_ > 0 } @list;
    my @negative = sort { $a <=> $b } map  { abs($_) } grep { $_ < 0 } @list;

    while ( @positive && @negative ) {
        if ( $positive[0] < $negative[0] ) {
            shift @positive;
        }
        elsif ( $positive[0] > $negative[0] ) {
            shift @negative;
        }
        else {
            shift @positive;
            shift @negative;
        }
    }

    return ( @positive, map { -$_ } @negative );
}

is_deeply( [ number_collision( 2, 3, -1 ) ], [ 2, 3 ], 'Test Case 1' );
is_deeply( [ number_collision( 3, 2, -4 ) ], [-4],     'Test Case 2' );
is_deeply( [ number_collision( 1, -1 ) ], [], 'Test Case 3' );

done_testing();
