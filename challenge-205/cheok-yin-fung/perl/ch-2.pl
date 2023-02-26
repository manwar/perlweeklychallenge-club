# The Weekly Challenge 205
# Task 2 Maximum XOR
use v5.30.0;
use warnings;
use List::Util qw/max/;

sub mx {
    my @arr = @_;
    my @xor;
    for my $i (0..$#arr) {
        for my $j ($i+1..$#arr) {
            push @xor, $arr[$i] ^ $arr[$j]
        }
    }
    return max @xor;
}

use Test::More tests=>3;
ok mx(1,2,3,4,5,6,7) == 7;
ok mx(2,4,1,3) == 7;
ok mx(10,5,7,12,8) == 15;
