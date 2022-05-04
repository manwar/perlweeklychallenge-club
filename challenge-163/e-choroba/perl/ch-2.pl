#!/usr/bin/perl
use warnings;
use strict;

use List::Util qw{ sum };

sub summations {
    my @list = @_;
    while (@list > 1) {
        my @new_list;
        my $s = 0;
        for my $i (1 .. $#list) {
            push @new_list, $s += $list[$i];
        }
        @list = @new_list;
    }
    return $list[0]
}

use Test::More tests => 3;

is summations(1, 2, 3, 4, 5), 42, 'Example 1';
is summations(1, 3, 5, 7, 9), 70, 'Example 2';

is summations(1 .. 20), 6564120420, 'Large input';
