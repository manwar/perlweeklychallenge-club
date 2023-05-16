use strict;
use warnings;

sub third_smallest {
    my @matrix = @_;
    my @flattened = map { @$_ } @matrix;
    @flattened = sort { $a <=> $b } @flattened;
    return $flattened[2];
}

my @matrix1 = ([3, 1, 2], [5, 2, 4], [0, 1, 3]);
my @matrix2 = ([2, 1], [4, 5]);
my @matrix3 = ([1, 0, 3], [0, 0, 0], [1, 2, 1]);

print third_smallest(@matrix1), "\n";
print third_smallest(@matrix2), "\n";
print third_smallest(@matrix3), "\n";

