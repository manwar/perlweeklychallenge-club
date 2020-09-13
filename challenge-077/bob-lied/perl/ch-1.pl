#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl
#=============================================================================
# Copyright (c) 2020, Bob Lied
#=============================================================================
# Perl Weekly Challenge 077 Task #1 > Fibonacci Sum
#=============================================================================
# You are given a positive integer $N.
# Write a script to find out all possible combination of Fibonacci Numbers
# required to get $N on addition.
# You are NOT allowed to repeat a number. Print 0 if none found.

use strict;
use warnings;
use v5.30;

use feature qw/ signatures /;
no warnings qw/ experimental::signatures /;

use lib "lib";
use FibSum qw(_fib);

# The biggest Fibonacci number that fits in an integer is f(93).
# That's way overkill -- only N up to about 3 digits is reasonable.
my $N_MAX = _fib(93);

sub Usage { "Usage: $0 N\n\t0 < N < 10000" };

my $N = shift;

die Usage() unless $N;
die Usage() unless 0 < $N && $N <= $N_MAX;

my $task = FibSum->new($N);
my $result = $task->run();

# Result is an array of arrays.
for my $answer ( @$result )
{
    say join(' + ', sort { $a <=> $b } @$answer), " = $N";
}
