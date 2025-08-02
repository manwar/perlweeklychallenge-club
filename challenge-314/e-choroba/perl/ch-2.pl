#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub sort_column(@list) {
    my $deleted = 0;
    for my $pos (0 .. length($list[0]) - 1) {
        my @chars = map substr($_, $pos, 1), @list;
        ++$deleted if grep $chars[ $_ - 1 ] gt $chars[$_], 1 .. $#chars;
    }
    return $deleted
}

use Test::More tests => 3 + 1;

is sort_column('swpc', 'tyad', 'azbe'), 2, 'Example 1';
is sort_column('cba', 'daf', 'ghi'), 1, 'Example 2';
is sort_column('a', 'b', 'c'), 0, 'Example 3';

is sort_column('ab', 'ac', 'ac'), 0, 'Or equal';
