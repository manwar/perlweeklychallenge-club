# The Weekly Challenge 199
# Task 2 Good Triplets
use v5.30.0;
use warnings;

sub good_triplets {
    my @a = $_[0]->@*;
    my ($x, $y, $z) = ($_[1], $_[2], $_[3]);
    my $ans = 0;
    for my $i (0..$#a) {
        for my $j ($i+1..$#a) {
            for my $k ($j+1..$#a) {
                $ans++ if 
                    (abs($a[$i]-$a[$j]) <= $x)
                        &&
                    (abs($a[$j]-$a[$k]) <= $y)
                        &&
                    (abs($a[$k]-$a[$i]) <= $z);
            }
        }
    }
    return $ans;
}

use Test::More tests=>2;
ok good_triplets([3,0,1,1,9,7], 7, 2, 3) == 4;
ok good_triplets([1,1,2,2,3], 0, 0, 1) == 0;
