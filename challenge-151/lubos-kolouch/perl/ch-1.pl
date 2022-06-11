use strict;
use warnings;

sub get_min_depth {
    my $input = shift;

    #Input: '1 | 2 3 | 4 5'

    # iterate through the layers. If the next layer does not have 2^n items,
    # there must be a leaf node

    my @layers = split /\|/, $input;

    my $layer_count = 1;
    for my $layer (@layers) {

        # if not defined means we are at the last layer
        return $layer_count unless defined $layers[$layer_count];

        my $items_count = scalar( split /\s+/, $layers[$layer_count] );
        return $layer_count unless $items_count == 2**$layer_count + 1;

        $layer_count++;
    }
}

use Test::More;
is( get_min_depth('1 | 2 3 | 4 5'),             2 );
is( get_min_depth('1 | 2 3 | 4 *  * 5 | * 6'),  3 );
is( get_min_depth('1 | 20 3 | 4 *  * 5 | * 6'), 3 );

done_testing;
