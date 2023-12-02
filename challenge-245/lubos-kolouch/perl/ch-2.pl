use strict;
use warnings;
use List::Util qw(sum);
use Test::More tests => 3;

sub largest_multiple_of_three {
    my @ints = @_;

    # Sort in descending order
    @ints = sort { $b cmp $a } @ints;

    # Function to remove the smallest element with a specific remainder
    sub remove_smallest {
        my ( $ints_ref, $remainder ) = @_;
        for ( my $i = $#$ints_ref ; $i >= 0 ; $i-- ) {
            if ( $ints_ref->[$i] % 3 == $remainder ) {
                splice( @$ints_ref, $i, 1 );
                return 1;
            }
        }
        return 0;
    }

    # Adjust the list to make the sum of its digits divisible by 3
    my $sum = sum(@ints);
    if ( $sum % 3 == 1 ) {
        remove_smallest( \@ints, 1 ) || ( remove_smallest( \@ints, 2 ) && remove_smallest( \@ints, 2 ) );
    }
    elsif ( $sum % 3 == 2 ) {
        remove_smallest( \@ints, 2 ) || ( remove_smallest( \@ints, 1 ) && remove_smallest( \@ints, 1 ) );
    }

    $sum = sum(@ints);
    return @ints && $sum % 3 == 0 ? join( '', @ints ) : -1;
}

# Test Cases
is( largest_multiple_of_three( 8, 1, 9 ),       981,  'Example 1' );
is( largest_multiple_of_three( 8, 6, 7, 1, 0 ), 8760, 'Example 2' );
is( largest_multiple_of_three(1),               -1,   'Example 3' );
