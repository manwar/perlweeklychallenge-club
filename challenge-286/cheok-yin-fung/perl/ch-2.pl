# The Weekly Challenge 286
# Task 2 Order Game
use v5.30;
use warnings;
use List::Util qw/max min pairs/;

sub og {
    my @ints = $_[0]->@*;
    my @arr = @ints;
    while (scalar @arr != 1) {
        @arr = pairs @arr;
        foreach my $i (0..$#arr) {
            print(($i%2 ? "max" : "min")."(".$arr[$i]->[0].",".$arr[$i]->[1].")");
            $arr[$i] = $i % 2 ? (max $arr[$i]->@*) : (min $arr[$i]->@*);
            say "=". $arr[$i];
        }
        say "";
    }
    return $arr[0];
}

use Test::More tests=>3;
ok og([2,1,4,5,6,3,0,2])==1;
ok og([0,5,3,2])==0;
ok og([9, 2, 1, 4, 5, 6, 0, 7, 3, 1, 3, 5, 7, 9, 0, 8])==2;
