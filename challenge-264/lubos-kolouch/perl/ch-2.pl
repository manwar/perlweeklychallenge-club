use strict;
use warnings;

sub create_target_array {
    my ($source, $indices) = @_;
    my @target;

    for my $i (0..$#$source) {
        splice(@target, $indices->[$i], 0, $source->[$i]);
    }

    return \@target;
}

# Test the function
use Test::More tests => 3;
is_deeply(create_target_array([0, 1, 2, 3, 4], [0, 1, 2, 2, 1]), [0, 4, 1, 3, 2]);
is_deeply(create_target_array([1, 2, 3, 4, 0], [0, 1, 2, 3, 0]), [0, 1, 2, 3, 4]);
is_deeply(create_target_array([1], [0]), [1]);
