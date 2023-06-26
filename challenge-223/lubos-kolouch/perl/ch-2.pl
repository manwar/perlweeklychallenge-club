use strict;
use warnings;
use List::Util qw(max);

sub max_coins {
    my @nums = ( 1, @_, 1 );
    my $n    = @nums;
    my @dp   = map { [ (0) x $n ] } 1 .. $n;
    for my $length ( 2 .. $n ) {
        for my $left ( 0 .. $n - $length ) {
            my $right = $left + $length;
            for my $i ( $left + 1 .. $right - 1 ) {
                $dp[$left][$right] = max( $dp[$left][$right],
                    $nums[$left] * $nums[$i] * $nums[$right] + $dp[$left][$i] + $dp[$i][$right] );
            }
        }
    }
    return $dp[0][ $n - 1 ];
}

print max_coins( 3, 1, 5, 8 );    # Outputs: 167
