#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub group_position($str) {
    my @matches;
    push @matches, $1 while $str =~ /((.)\2{2,})/g;
    $matches[0] //= "";
    return @matches
}

use Test::More tests => 3;

is_deeply [group_position('abccccd')], ['cccc'], 'Example 1';
is_deeply [group_position('aaabcddddeefff')], ['aaa', 'dddd', 'fff'],
    'Example 2';
is_deeply [group_position('abcdd')], [''], 'Example 3';
