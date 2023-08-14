use strict;
use warnings;
use Test::More;

sub good_triplets {
    my ( $x, $y, $z, @array ) = @_;
    my $count = 0;
    for my $i ( 0 .. $#array - 2 ) {
        for my $j ( $i + 1 .. $#array - 1 ) {
            for my $k ( $j + 1 .. $#array ) {
                $count++
                  if abs( $array[$i] - $array[$j] ) <= $x
                  && abs( $array[$j] - $array[$k] ) <= $y
                  && abs( $array[$i] - $array[$k] ) <= $z;
            }
        }
    }
    return $count;
}

# Test cases
is( good_triplets( 7, 2, 3, 3, 0, 1, 1, 9, 7 ), 4, 'Test Case 1' );
is( good_triplets( 0, 0, 1, 1, 1, 2, 2, 3 ), 0, 'Test Case 2' );

done_testing();
