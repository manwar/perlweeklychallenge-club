#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl
#=============================================================================
# Copyright (c) 2020, Bob Lied
#=============================================================================
# Perl Weekly Challenge 077 Task #2 > Lonely X
#=============================================================================
# You are given m x n character matrix consists of O and X only.
# Write a script to count the total number of X surrounded by O only.
# Print 0 if none found.
# Example 1:
# Input: [ O O X ]
#        [ X O O ]
#        [ X O O ]
#
# Output: 1 as there is only one X at the first row last column surrounded by only O.

use strict;
use warnings;
use v5.30;

use feature qw/ signatures /;
no warnings qw/ experimental::signatures /;

use Getopt::Long;

use lib "lib";
use LonelyX;

sub Usage { "Usage: $0 path-to-matrix" };

my $Verbose = 0;
GetOptions("verbose" => \$Verbose);

my $path = shift;

die Usage() unless $path;
die (Usage() ." ". $!) unless -r $path;

my $lx = LonelyX->new();
$lx->loadGrid($path);
$lx->showGrid() if ( $Verbose );

my $result = $lx->run();
say $result;

$lx->highlight() if ( $Verbose )
