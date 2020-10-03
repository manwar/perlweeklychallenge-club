#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl
#=============================================================================
# Copyright (c) 2020, Bob Lied
#=============================================================================
# Perl Weekly Challenge 080 Task #1 > Smallest Positive Number
#=============================================================================
# You are given unsorted list of integers @N.
# Write a script to find out the smallest positive number missing.

use strict;
use warnings;
use v5.30;

use feature qw/ signatures /;
no warnings qw/ experimental::signatures /;

use Getopt::Long;

use lib "lib";
use SmallestPositive;

sub Usage { "Usage: $0 args" };

my $Verbose = 0;
GetOptions('verbose' => \$Verbose);

# Allow anything that looks like a list as arguments
(my $argv = "@ARGV") =~ s/[,()]/ /g;
my @N = split(" ", $argv);

die "Usage: $0 list-of-integers" unless @N;

my $task = SmallestPositive->new(\@N);
my $result = $task->run();
say $result;
