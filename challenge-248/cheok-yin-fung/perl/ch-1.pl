# The Weekly Challenge 248
# Task 1 Shortest Distance
use v5.30.0;
use warnings;
use List::Util qw/min/;

sub sd {
    my $str = $_[0];
    my $chr = $_[1];
    my @arr;
    my $pre_k = 0;
    my $k = index($str,$chr,$pre_k);
    while ($k != -1 && $k < length $str) {
        $arr[$k] = 0;
        my $nxt_k = index($str,$chr,$k+1);
        $nxt_k = length $str if $nxt_k == -1;
        for my $j ($pre_k..$nxt_k-1) {
            $arr[$j] = defined($arr[$j]) ? min($arr[$j], $k-$j): abs($k-$j);
        }
        $pre_k = $k;
        $k = $nxt_k;
    }
    return [@arr];
}

use Test2::V0;
is sd("loveleetcode", "e"), [3,2,1,0,1,0,0,1,2,2,1,0];
is sd("aaab","b"), [3,2,1,0];
is sd("baaa","b"), [0,1,2,3];
done_testing();
