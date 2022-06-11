#!/usr/bin/env perl
# Perl weekly challenge 151
# Task 1: Binary tree depth
#
# See https://wlmb.github.io/2022/02/07/PWC151/#task-1-binary-tree-depth
use v5.12;
use warnings;
use Try::Tiny;
die "Usage: ./ch-1.pl T1 [T2]...\n"
    . "where Ti are trees of the form 'R1 | R2...'\n"
    . "and each row consists of nodes (strings) or an asterisk * (empty node)\n"
    unless @ARGV;
for my $tree (@ARGV){
    my @rows=split /\s*\|\s*/, $tree; # separate into rows.
    my $depth=0;   # Depth of first row is 1. This is above the first row
    try {
	foreach(@rows){
	    s/((\S)+)/$2/g; # replace contiguous characters by first
	    s/\s+//g; # remove spaces
	    die "\n" if length > 2**$depth; # row can't be larger than 2**depth
	    $_.=("*" x(2**$depth-length)); # Fill row with asterisks if necessary
	    # Two consecutive asterisks at even-odd position mean we are below a leave
	    # so we have finished our search;
	    last if m/^(..)*(\*\*)/;
	    ++$depth;  # increase and iterate
	}
	say "Input: $tree\nOutput: $depth";
    }
    catch { say "A row is too long in $tree";}
}
