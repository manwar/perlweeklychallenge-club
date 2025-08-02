use strict;
use warnings;
use List::Util qw(min);
use Test::More tests => 6;

sub number_game {
    my (@ints) = @_;
    my @result;

    while (@ints) {
        # Find the two smallest integers
        @ints = sort { $a <=> $b } @ints;
        my $min1 = shift @ints;
        my $min2 = shift @ints;

        # Add them to the result array in decreasing order
        push @result, ($min2, $min1);
    }

    return @result;
}

# Unit tests
is_deeply([number_game(2, 5, 3, 4)], [3, 2, 5, 4], 'Example 1');
is_deeply([number_game(9, 4, 1, 3, 6, 4, 6, 1)], [1, 1, 4, 3, 6, 4, 9, 6], 'Example 2');
is_deeply([number_game(1, 2, 2, 3)], [2, 1, 3, 2], 'Example 3');
is_deeply([number_game(1, 2, 3, 4, 5, 6)], [2, 1, 4, 3, 6, 5], 'Already sorted');
is_deeply([number_game(6, 5, 4, 3, 2, 1)], [2, 1, 4, 3, 6, 5], 'Reverse sorted');
is_deeply([number_game(5, 1, 5, 1, 2, 2)], [1, 1, 2, 2, 5, 5], 'Duplicate elements');

done_testing();
