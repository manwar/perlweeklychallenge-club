package Majority;

use strict;
use warnings;

use List::MoreUtils 'frequency';

sub element {
# Majority element in the list is the one that appears more than floor(size_of_list/2).
    my ( $self, @A ) = @_;
    my $majority_element = -1;

    my $floor = @A / 2;

    my %frequencies = frequency @A;

    for my $element ( @A ) {
        if ( $frequencies{$element} > $floor ) {
            $majority_element = $element;
            last;
        }
    }

    return $majority_element;
}

1;
