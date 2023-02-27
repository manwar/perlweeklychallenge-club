# The Weekly Challenge 205
# Task 1 Third Highest
use v5.30.0;
use warnings;
use List::Util qw/max uniq/;

sub th {
    my @arr = @_;
    @arr = uniq @arr;
    my $max = $arr[0];
    my $scmax = $arr[1];
    return $max if !defined($scmax);
    my $thmax = $arr[2];
    ($max, $scmax) = ($scmax, $max) if $scmax > $max;
    return $max if !defined($thmax);
    for my $i (2..$#arr) {
        $thmax = $arr[$i] if $arr[$i] > $thmax;
        ($thmax, $scmax) = ($scmax, $thmax) if $thmax > $scmax;
        ($max, $scmax) = ($scmax, $max) if $scmax > $max;
    }
    return $thmax;
}

use Test::More tests=>5;
ok th(5,3,4) == 3;
ok th(5,6) == 6;
ok th(5,4,4,3) == 3;
ok th(1,1,1,1) == 1;
ok th(1,2,3,4) == 2;
