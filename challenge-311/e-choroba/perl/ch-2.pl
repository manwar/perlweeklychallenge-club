#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::Util qw{ sum };

sub group_digit_sum($str, $int) {
    my $result = join "",
                 map sum(split //),
                 $str =~ /(.{1,$int})/g;
    return $int < length $result ? group_digit_sum($result, $int)
                                 : $result
}

use Test::More tests => 3 + 2;

is group_digit_sum('111122333', 3), '359', 'Example 1';
is group_digit_sum('1222312', 2), '76', 'Example 2';
is group_digit_sum('100012121001', 4), '162', 'Example 3';

is group_digit_sum('54', 2), 9, 'Single group';
is group_digit_sum('9', 1), 9, 'Length 1';
