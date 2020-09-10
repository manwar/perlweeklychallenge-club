#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl
#=============================================================================
# Copyright (c) 2020, Bob Lied
#=============================================================================
# Perl Weekly Challenge 076 Task #2 > Word Search
#=============================================================================

use strict;
use warnings;
use v5.30;

us feature qw/ signatures /;
no warnings qw/ experimental::signatures /;

use lib "lib";
use WordSearch;

sub Usage { "Usage: $0 args" };

my $arg = shift;
my @list = @ARGV;

die Usage() unless $arg;
die Usage() unless @list;

my $task = WordSearch->new();
my $result = WordSearch->run();
say $result;
