#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use constant WIDTH => 100;

sub line_counts($str, @widths) {
    my %width;
    @width{'a' .. 'z'} = @widths;
    my $line_tally = 1;
    my $line_width = 0;

    for my $char (split //, $str) {
        ++$line_tally, $line_width = 0
            if $line_width + $width{$char} > WIDTH;
        $line_width += $width{$char};
    }
    return $line_tally, $line_width
}

use Test2::V0;
plan(2);

is [line_counts('abcdefghijklmnopqrstuvwxyz',
                10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10,
                10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10)],
    [3, 60], 'Example 1';

is [line_counts('bbbcccdddaaa',
                4, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10,
                10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10)],
    [2, 4], 'Example 2';
