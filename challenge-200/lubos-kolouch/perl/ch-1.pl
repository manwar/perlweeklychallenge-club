use strict;
use warnings;
use Test::More;
use Data::Dumper;

sub arithmetic_slices {
    my @array = @_;
    return () if @array < 3;

    my @slices;
    for my $i ( 0 .. $#array - 2 ) {
        if ( $array[ $i + 1 ] - $array[$i] == $array[ $i + 2 ] - $array[ $i + 1 ] ) {
            my $diff  = $array[ $i + 1 ] - $array[$i];
            my @slice = @array[ $i, $i + 1, $i + 2 ];
            push @slices, [@slice];
            for my $j ( $i + 3 .. $#array ) {
                if ( $array[$j] - $array[ $j - 1 ] == $diff ) {
                    push @slice,  $array[$j];
                    push @slices, [@slice];
                }
                else {
                    last;
                }
            }
        }
    }
    return @slices;
}

# Test cases
my @test_case_1 = arithmetic_slices( 1, 2, 3, 4 );
is_deeply( \@test_case_1, [ [ 1, 2, 3 ], [ 1, 2, 3, 4 ], [ 2, 3, 4 ] ], 'Test Case 1' );

done_testing();
