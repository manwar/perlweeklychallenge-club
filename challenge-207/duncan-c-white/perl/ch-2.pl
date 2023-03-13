#!/usr/bin/perl
#
# Task 2: H-Index
# 
# You are given an array of integers containing citations a researcher
# has received for each paper.  Write a script to compute the researcher's
# H-Index. For more information please checkout:
# 
# https://en.wikipedia.org/wiki/H-index
# 
# The H-Index is the largest number h such that h articles have at least
# h citations each. For example, if an author has five publications, with
# 9, 7, 6, 2, and 1 citations (ordered from greatest to least), then the
# author's H-index is 3, because the author has three publications with 3
# or more citations. However, the author does not have four publications
# with 4 or more citations.
# 
# 
# Example 1
# 
#   Input: @citations = (10,8,5,4,3)
#   Output: 4
# 
# Because the 4th publication has 4 citations and the 5th has only 3.
# 
# Example 2
# 
#   Input: @citations = (25,8,5,3,3)
#   Output: 3
# 
# The H-Index is 3 because the fourth paper has only 3 citations.
# 
# MY NOTES: also pretty easy.  The Wikipedia entry sheds more light:
# 
# "First we order the citations from the largest to the lowest value.
#  Then, we look for the last position in which citation[h] >= h."
#  (This assumes array indexes start at 1, I think).
# 
# GUEST LANGUAGE: As a bonus, I also had a go at translating ch-2.pl into C
# (look in the C directory for that)
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;
use List::Util qw(min max);

my $debug=0;
die "Usage: h-index [--debug] intlist\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV > 0;

my @list = split( /,/, join(',',@ARGV) );

say "list: ", join(',',@list) if $debug;

@list = sort { $b <=> $a } @list;

say "sorted list: ", join(',',@list) if $debug;

my $h = -1;

foreach my $pos (0..$#list)
{
	$h = $pos+1 if $list[$pos] >= $pos+1;
}

say $h;
