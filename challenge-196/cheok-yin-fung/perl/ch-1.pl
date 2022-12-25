# The Weekly Challenge 196
# Task 1 Pattern 132
use v5.30.0;
use warnings;

sub one32 {
    my @a = @_;
    for my $i (0..$#a-2) {
        for my $j ($i+2..$#a) {
            if ($a[$j] > $a[$i]) {
                for my $k ($i+1..$j-1) {
                    return [$a[$i], $a[$k], $a[$j]] if $a[$k] > $a[$j];
                }
            }
        }
    }
    return [];
}


use Test::More tests=>4;
use Test::Deep;

cmp_deeply one32(3,1,4,2), [1,4,2];
cmp_deeply one32(1,2,3,4), [];
cmp_deeply one32(1,3,2,4,6,5), [1,3,2];
cmp_deeply one32(1,3,4,2), [1,3,2];
