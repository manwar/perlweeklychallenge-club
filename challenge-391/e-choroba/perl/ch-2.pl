#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub arrange_box(@boxes) {
    my @s = map $_->[1],
        sort { $a->[0] <=> $b->[0] || $b->[1] <=> $a->[1] }
        @boxes;
    my %last;
    @last{0 .. $#s} = ();
    my $length = 0;
    while (keys %last) {
        my %next;
        ++$length;
        for my $box (keys %last) {
            for my $following ($box + 1 .. $#s) {
                undef $next{$following} if $s[$box] < $s[$following];
            }
        }
        %last = %next;
    }
    return $length
}

use Test::More tests => 5 + 3;

is arrange_box([1, 3], [3, 5], [6, 8], [2, 4]), 4, 'Example 1';
is arrange_box([4, 5], [4, 6], [6, 7], [2, 3], [4, 3]), 3, 'Example 2';
is arrange_box([5, 5], [5, 5], [5, 5]), 1, 'Example 3';
is arrange_box([2, 100], [3, 200], [4, 300], [5, 50], [5, 400]), 4, 'Example 4';
is arrange_box([10, 20], [15, 10], [20, 30], [12, 18], [16, 25]), 3,
    'Example 5';

# And now some interesting examples:
is arrange_box([10, 20], [15, 10], [20, 30], [16, 18], [17, 25]),
    4, 'Start from the second';

is arrange_box([8, 4], [19, 17], [1, 9], [11, 5], [12, 18], [13, 6]),
    4, 'Backtracking';

is arrange_box([27, 16], [5, 15], [51, 83], [62, 82], [79, 46], [63, 73],
               [74, 74], [8, 39], [87, 22], [16, 41], [84, 86], [77, 76],
               [26, 58], [52, 9]),
    8, 'Skip several';
