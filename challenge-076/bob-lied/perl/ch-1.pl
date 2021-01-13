#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl
#=============================================================================
# Copyright (c) 2020, Bob Lied
#=============================================================================
# Perl Weekly Challenge 000 Task #1 > Prime Sum
# You are given a number $N.
# Write a script to find the minimum number of prime numbers required, whose summation gives you $N.
# For the sake of this task, please assume 1 is not a prime number.
#=============================================================================

use strict;
use warnings;
use v5.30;

use feature qw/ signatures /;
no warnings qw/ experimental::signatures /;


use lib "lib";
use PrimeSum;

sub Usage { "Usage: $0 N\n\t2 <= N <= 10000" };

my $N = shift;

die Usage() unless $N && $N > 1 && $N <= 10000;

my $task = PrimeSum->new($N);
my ($result, $list) = $task->run();
say "$N ==> $result [ ", join(', ', @$list), " ]";
