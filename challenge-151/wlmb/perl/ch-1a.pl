#!/usr/bin/env perl
# Perl weekly challenge 151
# Task 1: Binary tree depth
#
# See https://wlmb.github.io/2022/02/07/PWC151/#task-1-binary-tree-depth
use v5.12;
use warnings;
use Try::Tiny;
die "Usage: ./ch-1a.pl T1 [T2]...\n"
    . "where Ti are trees of the form 'R1 | R2...'\n"
    . "and each row consists of nodes (strings) or an asterisk * (empty node)\n"
    unless @ARGV;
for my $tree (@ARGV){
    my @rows=split /\s*\|\s*/, $tree; # separate into rows.
    my $depth=0;   # Depth of first row is 1. This is above the first row
    try {
        my $old='';
      ROW:
	foreach(@rows){
	    s/((\S)+)/$2/g; # replace contiguous characters by first
	    s/\s+//g; # remove spaces
	    die "A row is too long in $tree\n"
		if length > 2**$depth; # row can't be larger than 2**depth
	    $_.=("*" x(2**$depth-length)); # Fill row with asterisks if necessary
	    my $new=$_;
	    # A non-empty node below an empty one is an error.
	    while(s/^((\*\*)*)([^\*].|.[^\*])/$1\*\*/){
	        die "An empty node may not have descendants in $tree\n"
		   if substr($old,length($1)/2,1) eq "*";
	    }
	    # Two empty nodes below a non-empty node mean the search is over.
	    $_=$new;
	    while(s/^((..)*)\*\*/$1../){
		last ROW unless substr($old,length($1)/2,1) eq "*";
	    }
	    $old=$new;
	    ++$depth;
      }
	say "Input: $tree\nOutput: $depth";
    }
    catch { say $_;}
}
