# The Weekly Challenge 197
# Task 1 Move Zero
use v5.30.0;
use warnings;

sub mz {
    my @a = @_;
    for my $i (0..$#a-1) {
        my $j = $i;
        while ($j >= 0 && $a[$j+1] != 0 && $a[$j] == 0) {
            ($a[$j], $a[$j+1]) = ($a[$j+1], $a[$j]);
            $j--;
        }
    }
    return @a;
}


use Test::More tests=>3;
use Test::Deep;

cmp_deeply [mz(1, 0, 3, 0, 0, 5)], [1, 3, 5, 0, 0, 0];
cmp_deeply [mz(1, 6, 4)], [1, 6, 4];
cmp_deeply [mz(0, 1, 0, 2, 0)], [1, 2, 0, 0, 0];

