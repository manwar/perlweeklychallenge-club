#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl
#=============================================================================
# Copyright (c) 2020, Bob Lied
#=============================================================================
# Perl Weekly Challenge 080 Task #2 > Count Candies 
#=============================================================================
# You are given rankings of @N candidates.
# Write a script to find out the toal candies needed for all candidates.
# You are asked to follow the rules below:
# a) You must give at least one candy to each candidate.
# b) Candidate with higher ranking get more candies then ther immediate
#    neighbors on either side.

use strict;
use warnings;
use 5.030;

use feature qw/ signatures /;
no warnings qw/ experimental::signatures /;

use List::Util qw/ sum /;

my @candidate;

# Allow anything that looks like a list as arguments
(my $argv = "@ARGV") =~ s/[,()]/ /g;
@candidate = split(" ", $argv);

die "Usage: $0 list-of-numbers" unless @candidate;


# Make the boundaries easy by adding left and right elements that
# won't add to the total.
unshift @candidate, $candidate[ 0];
push    @candidate, $candidate[-1];

sub candy($left, $me, $right) { return 1 + ($me > $left) + ($me > $right); }

# range of indexes excludes first and last element
my $score = sum map { candy(@candidate[ (($_-1), $_, ($_+1) ) ]) } ( 1 .. ($#candidate-1) );
say "$score";
