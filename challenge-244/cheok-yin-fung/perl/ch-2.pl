# The Weekly Challenge 244
# Task 2 Group Hero
use v5.30.0;
use warnings;
use List::Util qw/max min/;
sub gh {
    my $ans = 0;
    my @nums = @_;
    my $num = $#nums+1;
    for my $grp (2 ..  2 << $#nums) {
        my $str = unpack("b$num", pack("s", $grp-1));
        my @arr = split "", $str;
        my @ints = map {$nums[$_]} grep {$arr[$_]} 0..$#nums;
        $ans += max(@ints)**2 * min(@ints);
    }
    return $ans;
}

use Test::More tests=>1;
ok gh(2,1,4)==141;
