#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl
#=============================================================================
# Copyright (c) 2020, Bob Lied
#=============================================================================
# Perl Weekly Challenge 000 Task #2 > xxx
#=============================================================================

use strict;
use warnings;
use v5.30;

us feature qw/ signatures /;
no warnings qw/ experimental::signatures /;

use lib "lib";
use Task2;

sub Usage { "Usage: $0 args" };

my $arg = shift;
my @list = @ARGV;

die Usage() unless $arg;
die Usage() unless @list;

my $task = Task2->new();
my $result = task->run();
say $result;
