# The Weekly Challenge 291
# Task 1 Middle Index
use v5.30;
use warnings;
use List::Util qw/sum/;

sub mi {
    my @arr = $_[0]->@*;
    my $rsum = (sum @arr) - $arr[0];
    my $lsum = 0;
    my $i = 0;
    while ($lsum != $rsum) {
        $i++;
        last if $i > $#arr;
        $lsum += $arr[$i-1];
        $rsum = $rsum - $arr[$i];
        # say ($i," ",$lsum," ",$rsum," ", $lsum+$rsum+$arr[$i]);
    }
    return $i if $lsum == $rsum;
    return -1;
}

use Test::More tests=>4;
ok mi([2,3,-1,8,4]) == 3;
ok mi([1,-1,4]) == 2;
ok mi([2,5])==-1;
ok mi([0,2,-1,-1])==0;
