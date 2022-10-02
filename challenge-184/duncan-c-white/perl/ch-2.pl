#!/usr/bin/perl
# 
# Task 2: Split Array
# 
# You are given list of strings containing 0-9 and a-z separated by space only.
# Write a script to split the data into two arrays, one for integers and
# one for alphabets only.
# 
# Example 1
# 
# 	Input: @list = ( 'a 1 2 b 0', '3 c 4 d')
# 	Output: [[1,2,0], [3,4]] and [['a','b'], ['c','d']]
# 
# Example 2
# 
# 	Input: @list = ( '1 2', 'p q r', 's 3', '4 5 t')
# 	Output: [[1,2], [3], [4,5]] and [['p','q','r'], ['s'], ['t']]
# 
# MY NOTES: Also seems pretty simple.
# 
# GUEST LANGUAGE: As a bonus, I also had a go at translating ch-2.pl
# into C (look in the C directory for that).
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;

my $debug=0;
die "Usage: split-array [--debug] 'csv_string'+\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV>0;

my @num;
my @let;

foreach my $list (@ARGV)
{
	$list =~ tr/,/ /;
	my @x = split(/\s+/,$list);
	my @a = grep { /\d/ } @x;
	push @num, [ @a ] if @a;
	@a = grep { /[a-z]/ } @x;
	push @let, [ @a ] if @a;
}

#say Dumper(\@let);
#say Dumper(\@num);

my $letstr = "[". join( ', ', map { "[".join(',',@$_)."]" } @let ) . "]";
my $numstr = "[". join( ', ', map { "[".join(',',@$_)."]" } @num ) . "]";

say "Output: $numstr and $letstr";
