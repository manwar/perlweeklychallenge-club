#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::Util qw{ sum };
use POSIX qw{ ceil };

sub absent_smallest_positive(@arr) {
    return 1 unless @arr;

    my %in;
    @in{ @arr } = ();

    my $avg = sum(0, @arr) / @arr;
    my $i = ceil($avg);
    ++$i if $avg == $i;
    $i = 1 if $i < 1;
    ++$i while exists $in{$i};
    return $i
}

use Test::More tests => 5 + 1;

is absent_smallest_positive(1, 2, 4, 5, 6), 7, 'Example 1';
is absent_smallest_positive(-5, -2, -1, 3), 1, 'Example 2';
is absent_smallest_positive(1, 2, 3), 4, 'Example 3';
is absent_smallest_positive(2, 3, 7, 8), 6, 'Example 4';
is absent_smallest_positive(1, 1, 1, 10), 4, 'Example 5';

is absent_smallest_positive(), 1, 'Empty array';
