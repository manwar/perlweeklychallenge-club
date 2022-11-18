#! /usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use constant {
    MAX => 1,
    MAX_BUT_ONE => 0,
};

sub twice_largest ($list) {
    return 1 if 1 == @$list;

    my @last2 = @$list[ $list->[0] < $list->[1] ? (0, 1) : (1, 0)];
    for my $i (2 .. $#$list) {
        if ($list->[$i] > $last2[MAX_BUT_ONE]) {
            if ($list->[$i] > $last2[MAX]) {
                @last2[MAX_BUT_ONE, MAX] = ($last2[MAX], $list->[$i]);
            } else {
                $last2[MAX_BUT_ONE] = $list->[$i];
            }
        }
    }
    return ($last2[MAX] >= $last2[MAX_BUT_ONE] * 2) ? 1 : -1
}

use Test::More tests => 4 + 3;

is twice_largest([1, 2, 3, 4]), -1, 'Example 1';
is twice_largest([1, 2, 0, 5]),  1, 'Example 2';
is twice_largest([2, 6, 3, 1]),  1, 'Example 3';
is twice_largest([4, 5, 2, 3]), -1, 'Example 4';

is twice_largest([2]), 1, 'Single element';
is twice_largest([2, 5]),  1, 'Two elements positive';
is twice_largest([2, 3]), -1, 'Two elements negative';
