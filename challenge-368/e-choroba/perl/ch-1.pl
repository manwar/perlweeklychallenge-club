#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::Util qw{ max };

sub make_it_bigger($str, $char) {
    my $pos = -1;
    my @candidates;
    while (-1 != ($pos = index $str, $char, $pos + 1)) {
        substr my $s = $str, $pos, 1, "";
        push @candidates, $s;
    }
    return max(@candidates)
}

use Test::More tests => 5;

is make_it_bigger('15456', '5'), '1546', 'Example 1';
is make_it_bigger('7332', '3'), '732', 'Example 2';
is make_it_bigger('2231', '2'), '231', 'Example 3';
is make_it_bigger('543251', '5'), '54321', 'Example 4';
is make_it_bigger('1921', '1'), '921', 'Example 5';
