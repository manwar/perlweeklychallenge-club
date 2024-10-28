#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::Util qw{ sum0 };

sub similar_dominos(@dominos) {
    my %normalised;
    ++$normalised{ join ' ', sort { $a <=> $b } @$_ } for @dominos;
    return sum0(grep $_ > 1, values %normalised)
}

use Test::More tests => 2 + 1;

is similar_dominos([1, 3], [3, 1], [2, 4], [6, 8]), 2, 'Example 1';
is similar_dominos([1, 2], [2, 1], [1, 1], [1, 2], [2, 2]), 3, 'Example 2';

is similar_dominos([1, 3], [3, 2], [2, 4], [6, 8]), 0, 'Zero';
