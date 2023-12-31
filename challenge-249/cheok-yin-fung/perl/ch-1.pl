# The Weekly Challenge 249
# Task 1 Equal Pairs
use v5.30.0;
use warnings;

use Data::Printer;

sub equal_pairs {
    my @arr = @_;
    # p @arr;
    @arr = sort {$a<=>$b} @arr;
    # p @arr;
    my @ans;
    for my $i (0..$#arr) {
        next unless !($i % 2);
        push @ans, [$arr[$i], $arr[$i+1]] if $arr[$i] == $arr[$i+1];
    }
    return [@ans];
}

use Test::More tests=>2;
use Test::Deep;

cmp_deeply 
           [[2, 2], [2, 2], [3, 3]],
           equal_pairs 3, 2, 3, 2, 2, 2 
;
    #      [(2, 2), (3, 3), (2, 2)] equals to [2,2,3,3,2,2];
cmp_deeply [], equal_pairs 1,2,3,4;



