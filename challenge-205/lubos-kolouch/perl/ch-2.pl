use strict;
use warnings;
use Test::More;

sub find_max_xor {
    my @array   = @_;
    my $max_xor = 0;
    for my $i ( 0 .. $#array ) {
        for my $j ( $i + 1 .. $#array ) {
            my $xor = $array[$i] ^ $array[$j];
            if ( $xor > $max_xor ) {
                $max_xor = $xor;
            }
        }
    }
    return $max_xor;
}

# Test cases
is( find_max_xor( 1, 2, 3, 4, 5, 6, 7 ), 7,  "Example 1" );
is( find_max_xor( 2, 4, 1, 3 ),          7,  "Example 2" );
is( find_max_xor( 10, 5, 7, 12, 8 ),     15, "Example 3" );
is( find_max_xor( 2, 2, 2, 2 ),          0,  "All elements the same" );

done_testing();
