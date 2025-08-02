use strict;
use warnings;

sub sum_of_special_squares {
    my (@ints) = @_;
    my $n      = scalar @ints;
    my $sum    = 0;

    for my $i ( 1 .. $n ) {
        $sum += $ints[ $i - 1 ]**2 if $n % $i == 0;
    }
    return $sum;
}

# Tests
use Test::More tests => 2;
is( sum_of_special_squares( 1, 2, 3, 4 ), 21, 'Test Example 1' );
is( sum_of_special_squares( 2, 7, 1, 19, 18, 3 ), 63, 'Test Example 2' );
