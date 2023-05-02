#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::Util qw{ max };


sub collect_points(@list) {
    return max(_collect_points(@list))
}

sub _collect_points(@list) {
    return scalar @list if 1 >= @list;

    my %scores;
    my $pos = 0;
    while ($pos <= $#list) {
        my $next = $pos;
        ++$next while $next < $#list && $list[ $next + 1 ] == $list[$pos];

        my @rest = _collect_points(@list[0 .. $pos - 1, $next + 1 .. $#list]);
        my $length = 1 + $next - $pos;
        @scores{ map $length * $length + $_, @rest } = ();
        $pos = $next + 1;
    }
    return keys %scores
}


use Test::More tests => 4 + 2;

is collect_points(2, 4, 3, 3, 3, 4, 5, 4, 2), 23, 'Example 1';
is collect_points(1, 2, 2, 2, 2, 1), 20, 'Example 2';
is collect_points(1), 1, 'Example 3';
is collect_points(2, 2, 2, 1, 1, 2, 2, 2), 40, 'Example 4';

is collect_points(1, 2), 2, 'Simple 2';
is collect_points(1, 1), 4, 'Simple 4';
