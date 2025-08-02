use strict;
use warnings;
use Test::More tests => 5;

sub bitwise_or_with_trailing_zero {
    my @ints = @_;
    my $n = scalar @ints;

    for my $i (0 .. $n - 2) {
        for my $j ( $i + 1 .. $n - 1) {
            if (($ints[$i] | $ints[$j]) % 2 == 0) {
                return 1;
            }
        }
    }
    return 0;
}

# Unit tests
is(bitwise_or_with_trailing_zero(1, 2, 3, 4, 5), 1, 'Example 1');
is(bitwise_or_with_trailing_zero(2, 3, 8, 16), 1, 'Example 2');
is(bitwise_or_with_trailing_zero(1, 2, 5, 7, 9), 0, 'Example 3');
is(bitwise_or_with_trailing_zero(1, 3, 5, 7, 9), 0, 'No trailing zero');
is(bitwise_or_with_trailing_zero(2, 4, 6, 8, 10), 1, 'All even');

done_testing();
