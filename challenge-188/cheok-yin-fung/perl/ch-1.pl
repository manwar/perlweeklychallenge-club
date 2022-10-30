# The Weekly Challenge 188
# Task 1 Divisible Pairs

use v5.30.0;

sub divisible_pairs {
    my @list = $_[0]->@*;
    my $k = $_[1];

    my $p = 0;
    for my $i (0..scalar @list - 2) {
        for my $j ($i+1 .. scalar @list - 1) {
            $p++ if !(($list[$i] + $list[$j]) % $k);
        }
    }
    return $p;
}

use Test::More tests=>5;
ok divisible_pairs([4,5,1,6], 2) == 2;
ok divisible_pairs([1,2,3,4], 2) == 2;
ok divisible_pairs([1,3,4,5], 3) == 2;
ok divisible_pairs([5,1,2,3], 4) == 2;
ok divisible_pairs([7,2,4,5], 4) == 1;
