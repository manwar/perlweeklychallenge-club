# The Weekly Challenge 244
# Task 1 Count Smaller
use v5.30.0;
use warnings;

sub cs {
    my @int = @_;
    my @ans;
    for my $k (0..$#int) {
        push @ans, 0;
        for my $i (0..$#int) {
            $ans[-1]++ if $int[$i]<$int[$k];
        }
    }
    return [@ans];
}

use Test::More tests=>3;
use Test::Deep;
cmp_deeply cs(8,1,2,2,3),[4,0,1,1,3];
cmp_deeply cs(6,5,4,8),[2,1,0,3];
cmp_deeply cs(2,2,2),[0,0,0];
