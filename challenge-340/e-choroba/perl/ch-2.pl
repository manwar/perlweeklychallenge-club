#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub ascending_numbers($str) {
    my @numbers = $str =~ /(\d+)/ag;
    for my $i (1 .. $#numbers) {
        return if $numbers[$i] <= $numbers[ $i - 1 ];
    }
    return 1
}

use constant { true => !0, false => !1 };
use Test2::V0;
plan(5 + 1);

is ascending_numbers('The cat has 3 kittens 7 toys 10 beds'),
    bool(true),
    'Example 1';
is ascending_numbers('Alice bought 5 apples 2 oranges 9 bananas'),
    bool(false),
    'Example 2';
is ascending_numbers('I ran 1 mile 2 days 3 weeks 4 months'),
    bool(true),
    'Example 3';
is ascending_numbers('Bob has 10 cars 10 bikes'),
    bool(false),
    'Example 4';
is ascending_numbers('Zero is 0 one is 1 two is 2'),
    bool(true),
    'Example 5';

is ascending_numbers('There are no numbers'), bool(true), 'No numbers';
