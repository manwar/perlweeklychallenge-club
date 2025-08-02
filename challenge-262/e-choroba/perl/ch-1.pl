#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::MoreUtils qw{ part };
use List::Util qw{ max };

sub max_positive_negative(@ints) {
    max(map scalar @{ $_ // [] }, part { $_ > 0 } grep $_, @ints)
}

use Test::More tests => 3 + 1;

is max_positive_negative(-3, 1, 2, -1, 3, -2, 4), 4, 'Example 1';
is max_positive_negative(-1, -2, -3, 1), 3, 'Example 2';
is max_positive_negative(1, 2), 2, 'Example 3';

is max_positive_negative(0, 0, 0, -2, -3, 1, 0), 2, 'Zeros not counted';
