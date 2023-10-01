# The Weekly Challenge 236
# Task 2 Array Loops
use v5.30;
use warnings;

sub al {
    my @ints = @_;
    my $loop = 0;
    my @traversed;
    for my $i (0..$#ints) {
        $traversed[$i] = 0;
    }
    for my $i (0..$#ints) {
        next if $traversed[$i];
        my $k_0 = $i;
        # print $k_0;
        $traversed[$k_0] = 1;
        my $k = $ints[$k_0];
        while ($k != $k_0) {
            $traversed[$k] = 1;
            # print " ", $k;
            $k = $ints[$k];
        }
        # say "";
        $loop++;
    }
    return $loop;
}

use Test::More tests=>3;
ok al(4,6,3,8,15,0,13,18,7,16,14,19,17,5,11,1,12,2,9,10)==3;
ok al(0,1,13,7,6,8,10,11,2,14,16,4,12,9,17,5,3,18,15,19)==6;
ok al(9,8,3,11,5,7,13,19,12,4,14,10,18,2,16,1,0,15,6,17)==1;
