#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

my %REPLACE = ("" => 'o', al => 'al');
sub goal_parser($str) {
    $str =~ s/\(((?:al)?)\)/$REPLACE{$1}/gr
}

use Test::More tests => 5 + 1;

is goal_parser('G()(al)'), 'Goal', 'Example 1';
is goal_parser('G()()()()(al)'), 'Gooooal', 'Example 2';
is goal_parser('(al)G(al)()()'), 'alGaloo', 'Example 3';
is goal_parser('()G()G'), 'oGoG', 'Example 4';
is goal_parser('(al)(al)G()()'), 'alalGoo', 'Example 5';

is goal_parser(""), "", 'Empty';
