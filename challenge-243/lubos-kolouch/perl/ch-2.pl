use strict;
use warnings;
use Test::More tests => 2;

sub floor_sum {
    my @nums = @_;
    my $sum  = 0;
    for my $i ( 0 .. $#nums ) {
        for my $j ( 0 .. $#nums ) {
            $sum += int( $nums[$i] / $nums[$j] );
        }
    }
    return $sum;
}

# Tests
is( floor_sum( 2, 5, 9 ), 10, 'Test Example 1' );
is( floor_sum( 7, 7, 7, 7, 7, 7, 7 ), 49, 'Test Example 2' );
