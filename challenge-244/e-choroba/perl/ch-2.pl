#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::Util qw{ min max };

sub group_hero(@nums) {
    my @indicator = (0) x @nums;
    $indicator[-1] = 1;
    my $sum = 0;
    while (1) {
        my @group = @nums[grep $indicator[$_], 0 .. $#nums];
        $sum += max(@group) ** 2 * min(@group);

        my $i = $#indicator;
        $indicator[$i--] = 0 while $indicator[$i];
        ++$indicator[$i];
        last if $i < 0;
    }
    return $sum
}

use Test::More tests => 1;
is group_hero(2, 1, 4), 141, 'Example 1';
