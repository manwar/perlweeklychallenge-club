use strict;
use warnings;

sub merge_items {
    my ( $items1, $items2 ) = @_;
    my %merged;
    foreach my $item ( @$items1, @$items2 ) {
        my ( $item_id, $quantity ) = @$item;
        $merged{$item_id} += $quantity;
    }
    return [ map { [ $_, $merged{$_} ] } sort { $a <=> $b } keys %merged ];
}

# Test cases
use Data::Dumper;
print Dumper(
    merge_items( [ [ 1, 1 ], [ 2, 1 ], [ 3, 2 ] ], [ [ 2, 2 ], [ 1, 3 ] ] ) );
print Dumper(
    merge_items(
        [ [ 1, 2 ], [ 2, 3 ], [ 1, 3 ], [ 3, 2 ] ],
        [ [ 3, 1 ], [ 1, 3 ] ]
    )
);
print Dumper(
    merge_items( [ [ 1, 1 ], [ 2, 2 ], [ 3, 3 ] ], [ [ 2, 3 ], [ 2, 4 ] ] ) );
