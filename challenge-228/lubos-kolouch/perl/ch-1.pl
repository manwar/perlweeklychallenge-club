use strict;
use warnings;
use List::Util qw(sum);

sub unique_sum {
    my @array = @_;
    my %counts;

    $counts{$_}++ for @array;
    my @unique = grep { $counts{$_} == 1 } keys %counts;

    return sum(@unique) // 0;
}

print unique_sum(2, 1, 3, 2), "\n";  # Output: 4
print unique_sum(1, 1, 1, 1), "\n";  # Output: 0
print unique_sum(2, 1, 3, 4), "\n";  # Output: 10
