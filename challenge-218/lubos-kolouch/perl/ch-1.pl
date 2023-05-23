use strict;
use warnings;
use List::Util qw(min max);

sub max_triplet_product {
    my @nums = sort { $a <=> $b } @_;
    return max($nums[0] * $nums[1] * $nums[-1], $nums[-1] * $nums[-2] * $nums[-3]);
}

print max_triplet_product(3, 1, 2), "\n";  # Output: 6
print max_triplet_product(4, 1, 3, 2), "\n";  # Output: 24
print max_triplet_product(-1, 0, 1, 3, 1), "\n";  # Output: 3
print max_triplet_product(-8, 2, -9, 0, -4, 3), "\n";  # Output: 216

