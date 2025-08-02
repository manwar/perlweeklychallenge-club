use strict;
use warnings;
use Test::More tests => 3;

sub distribute_elements {
    my @ints = @_;
    my @arr1;
    my @arr2;

    # Initial placement
    push @arr1, shift @ints if @ints;
    push @arr2, shift @ints if @ints;

    # Distribute remaining elements
    foreach my $elem (@ints) {
        if ($arr1[-1] > $arr2[-1]) {
            push @arr1, $elem;
        } else {
            push @arr2, $elem;
        }
    }

    # Concatenate and return result
    return (@arr1, @arr2);
}

# Unit tests
is_deeply([distribute_elements(2, 1, 3, 4, 5)], [2, 3, 4, 5, 1], 'Example 1');
is_deeply([distribute_elements(3, 2, 4)], [3, 4, 2], 'Example 2');
is_deeply([distribute_elements(5, 4, 3, 8)], [5, 3, 4, 8], 'Example 3');

done_testing();
