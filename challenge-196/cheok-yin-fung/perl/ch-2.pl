# The Weekly Challenge 196
# Task 2 Range List
use v5.30.0;
use warnings;

sub rl {
    my @a = @_;
    my @rl;
    my $range = [$a[0], $a[0]];
    my $i = 1;
    while ($i <= $#a) {
        if ($a[$i] == $a[$i-1]+1) {
            $range->[1]++;
        } else {
            push @rl, $range if $range->[0] < $range->[1];
            $range = [$a[$i], $a[$i]];
        }
        $i++;
    }
    push @rl, $range if $range->[0] < $range->[1];
    return [@rl];
}


use Test::More tests=>3;
use Test::Deep;

cmp_deeply rl(1,3,4,5,7), [[3,5]];
cmp_deeply rl(1,2,3,6,7,9), [[1,3], [6,7]];
cmp_deeply rl(0,1,2,4,5,6,8,9), [[0,2], [4,6], [8,9]];
