#!/usr/bin/env perl
# Perl weekly challenge 127
# Task 2:  Conflict intervals
#
# See https://wlmb.github.io/2021/08/23/PWC127/#task-2-conflict-intervals
use warnings;
use strict;
use v5.12;
use PDL;
use PDL::IO::Misc;
use PDL::NiceSlice;

# read all intervals into a 2D array
my $ints=(rcols *STDIN,[])->transpose;
# check constraint
die "Expected a<b for every interval (a,b)" if ($ints((0))>=$ints((1)))->any;
# build matrix: overlap(i,j)=1 iff i and j overlap
my $overlap=($ints((0),:,*1)<$ints((1),*1,:))&($ints((1),:,*1)>$ints((0),*1,:));
# Select intervals that overlap previous ones
my $overlap_previous=$overlap&($overlap->xvals>$overlap->yvals);
# Indices of conflicting intervals
my $conflicting_indices=$overlap_previous->transpose->orover->which;
# The actual conflicting intervals.
my $conf_ints=$ints->transpose->($conflicting_indices)->transpose;
# Print result
say "Input: $ints\nConflicting intervals: ",
     $conf_ints->isempty?"None":"$conf_ints\nConflicts array: $overlap_previous";
