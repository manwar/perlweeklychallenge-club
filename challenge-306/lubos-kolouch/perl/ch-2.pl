use strict;
use warnings;

=head2 last_element

Determine the last element left after repeatedly picking and processing the two largest elements.

The process is:
1. Pick the two largest elements (x and y).
2. If x == y, remove both.
3. If x != y, remove both and add (x - y) to the array.
Repeat until at most one element remains.

@param @ints Array of integers.

@return The last remaining element, or 0 if none.

=cut

sub last_element {
    my @ints = @_;
    @ints = sort { $b <=> $a } @ints;    # Sort descending
    while ( @ints >= 2 ) {
        my $x = shift @ints;
        my $y = shift @ints;
        if ( $x != $y ) {
            my $diff = $x - $y;
            push @ints, $diff;
            @ints = sort { $b <=> $a } @ints;    # Re-sort
        }
    }
    return @ints ? $ints[0] : 0;
}

# Tests
use Test::More tests => 6;

is( last_element( 3, 8, 5, 2, 9, 2 ), 1,  'Example 1' );
is( last_element( 3, 2, 5 ),          0,  'Example 2' );
is( last_element(5),                  5,  'Single element' );
is( last_element( 5, 5 ),             0,  'Two equal elements' );
is( last_element( 10, 10, 10 ),       10, 'Three equal elements' );
is( last_element( 7, 3, 7 ),          3,  'Diff after removal' );

done_testing();
