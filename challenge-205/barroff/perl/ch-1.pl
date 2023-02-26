#!/usr/bin/env perl

use v5.36;
use strict;
use warnings;

use List::MoreUtils qw(uniq);

sub third_highest_sorted (@list) {
    scalar @list >= 3 ? $list[-3] : $list[-1];
}

sub third_highest (@list) {
    my @sorted = sort( uniq(@list) );
    third_highest_sorted @sorted;
}

sub MAIN() {
    use Test::Simple tests => 3;
    use Test::More import => [qw( is plan )];

    is third_highest( 5, 3, 4 ),    3, 'works for (5, 3, 4)';
    is third_highest( 5, 6 ),       6, 'works for (5, 6)';
    is third_highest( 5, 4, 4, 3 ), 3, 'works for (5, 4, 4, 3)';
}

MAIN();
