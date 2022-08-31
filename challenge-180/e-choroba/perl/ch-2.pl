#!/usr/bin/perl
use warnings;
use strict;

sub trim_list {
    my ($arr, $threshold) = @_;
    return [grep $_ > $threshold, @$arr]
}


use Test2::V0;
plan 2;

is trim_list([1,4,2,3,5], 3), [4,5], 'Example 1';
is trim_list([9,0,6,2,3,8,5], 4), [9,6,8,5], 'Example 2';
