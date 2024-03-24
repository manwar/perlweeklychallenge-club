use strict;
use warnings;

sub multiply_by_two {
    my ($ints, $start) = @_;
    my %hash = map { $_ => 1 } @$ints;

    while (exists $hash{$start}) {
        $start *= 2;
    }

    return $start;
}

# Test cases
use Test::More tests => 3;
is(multiply_by_two([5, 3, 6, 1, 12], 3), 24, 'Test Case 1');
is(multiply_by_two([1, 2, 4, 3], 1), 8, 'Test Case 2');
is(multiply_by_two([5, 6, 7], 2), 2, 'Test Case 3');
done_testing();
