# The Weekly challenge 233
# Task 2 Frequency Sort
use v5.30.0;
use warnings;
use List::MoreUtils qw/frequency/;

sub fs {
    my @ints = @_;
    my %freq = frequency @ints;
    @ints = sort { 
        ($freq{$a} <=> $freq{$b})
                || 
        ($freq{$a} == $freq{$b} && $b<=>$a)} @ints;
    return [@ints];
}

use Test::More tests=>4;
use Test::Deep;
cmp_deeply fs(1,1,2,2,2,3), [3,1,1,2,2,2];
cmp_deeply fs(2,3,1,3,2), [1,3,3,2,2];
cmp_deeply fs(-1,1,-6,4,5,-6,1,4,1), [5,-1,4,4,-6,-6,1,1,1];
cmp_deeply fs(1,3,2), [3,2,1];
