#! /usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub total_zero_naive ($x, $y) {
    my $count = 0;
    until ($x == 0 || $y == 0) {
        ++$count;
        my $prev_x = $x;
        $x -= $y if $x >= $y;
        $y -= $prev_x if $y >= $prev_x;
    }
    return $count
}

sub total_zero ($x, $y) {
    my $count = 0;
    until ($x == 0 || $y == 0) {
        ($x, $y) = ($y, $x) if $y < $x;
        my $r = $y % $x;
        $count += ($y - $r) / $x;
        $y = $r;
    }
    return $count
}

use Test::More tests => 2 * (5 + 2);

for my $tz (\&total_zero_naive, \&total_zero) {
    is $tz->(5, 4), 5, 'Example 1';
    is $tz->(4, 6), 3, 'Example 2';
    is $tz->(2, 5), 4, 'Example 3';
    is $tz->(3, 1), 3, 'Example 4';
    is $tz->(7, 4), 5, 'Example 5';

    is $tz->(7, 7), 1, 'Same';
    is $tz->(1213, 3010), 61, 'Large';
}

use Benchmark qw{ cmpthese };
cmpthese(-3, {
    fast => sub { total_zero(1213, 3010) },
    slow => sub { total_zero_naive(1213, 3010) },
});

__END__
         Rate slow fast
slow  93177/s   -- -75%
fast 377500/s 305%   --
