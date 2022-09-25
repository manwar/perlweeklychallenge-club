#!/usr/bin/perl
# 
# Task 1: Unique Array
# 
# You are given list of arrayrefs.
# Write a script to remove the duplicate arrayrefs from the given list.
# 
# Example 1
# 
# Input: @list = ([1,2], [3,4], [5,6], [1,2])
# Output: ([1,2], [3,4], [5,6])
# 
# Example 2
# 
# Input: @list = ([9,1], [3,7], [2,5], [2,5])
# Output: ([9, 1], [3,7], [2,5])
# 
# MY NOTES: nice and easy, only challenge is how to store a representation
# of an entire array as a hash key: obvious option is to join(',',@items).
# Also need to decide how to specify the inputs as command line args, let's
# go with each list as a single csv item (which means we could cheat and
# nerver split them into arrays, but we won't..)
# 
# GUEST LANGUAGE: As a bonus, I also had a go at translating ch-1.pl
# into C (look in the C directory for that).  It's not a direct translation
# of the Perl solution because that involves sets of joined strings, instead
# it does it the obvious low-tech way: finding duplicate arrays and deleting
# them.
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;


my $debug=0;
die "Usage: unique-array [--debug] comma_sep_list_of_ints+\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV>0;

# all arguments are comma-separated lists of ints.
my @list = map { [ split(/,/, $_) ] } @ARGV;

#die Dumper(\@list);

# filter out duplicate sub-arrays
my %seen;
@list = grep { ! $seen{join(',',@$_)}++ } @list;

my $str = join( ', ', map { '['.join(',',@$_).']' } @list );
say $str;
