#!/usr/bin/perl
# 
# Task 1: Max Index
# 
# You are given a list of integers.
# Write a script to find the index of the first biggest number in the list.
# 
# Example
# 
# Input: @n = (5, 2, 9, 1, 7, 6)
# Output: 2 (as 3rd element in the list is the biggest number)
# 
# Input: @n = (4, 2, 3, 1, 5, 0)
# Output: 4 (as 5th element in the list is the biggest number)
# 
# MY NOTES: nice and easy.
#
# GUEST LANGUAGE: As a bonus, I also had a go at translating ch-1.pl
# into C (look in the C directory for that).
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;


my $debug=0;
die "Usage: max-index [--debug] list_of_ints\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV>0;

# all arguments should either be single ints, or
# comma-separated lists of ints.  join them all up
my $all = join(',',@ARGV);
$all =~ s/\s+/,/g;
my @list = split(/,/, $all);

#die Dumper(\@list);

my $maxpos = 0;
my $maxval = $list[0];

foreach my $pos (1..$#list)
{
	next if $maxval >= $list[$pos];
	$maxval = $list[$pos];
	$maxpos = $pos;
}

say $maxpos;
