# The Weekly Challenge
# Task 2 Last Member
use v5.30.0;
use warnings;
use List::Util qw/max first/;

sub lm {
    my @arr = @_;
    while (scalar @arr > 1) {
        my $m = max @arr;
        my $ind = first {$arr[$_] == $m} 0..$#arr;
        my @brr = map {$arr[$_]} grep {$_ != $ind} 0..$#arr;
        my $n = max @brr;
        my $jnd = first {$brr[$_] == $n} 0..$#brr;
        my @crr = map {$brr[$_]} grep {$_ != $jnd} 0..$#brr;
        push @crr, $m-$n if $m != $n;
        @arr = @crr;
    }
    return 0 if scalar @arr == 0;
    return $arr[0];
}

use Test::More tests=>3;
ok lm(2, 7, 4, 1, 8, 1) == 1;
ok lm(1) == 1;
ok lm(1, 1) == 0;
