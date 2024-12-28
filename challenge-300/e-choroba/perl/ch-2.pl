#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub nested_array(@ints) {
    my $max_length = 0;
    for my $i (0 .. $#ints) {
        my $length = 0;
        my $set = $ints[$i];
        my %used;
        while (! exists $used{$set}) {
            undef $used{$set};
            $set = $ints[$set];
            ++$length
        }
        $max_length = $length if $length > $max_length;
    }
    return $max_length
}

use Test::More tests => 2;

is nested_array(5, 4, 0, 3, 1, 6, 2), 4, 'Example 1';
is nested_array(0, 1, 2), 1, 'Example 2';
