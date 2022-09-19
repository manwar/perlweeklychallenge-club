#!/usr/bin/perl
# 
# Task 1: Damm Algorithm
# 
# You are given a positive number, $n.
# 
# Write a script to validate the given number against the included check digit.
# 
# Please checkout the wikipedia page
# 	https://en.wikipedia.org/wiki/Damm_algorithm
# for more information.
# 
# Example 1
# 
# 	Input: $n = 5724
# 	Output: 1 as it is valid number
# 
# Example 2
# 
# 	Input: $n = 5727
# 	Output: 0 as it is invalid number
# 
# MY NOTES: ok, sounds pretty easy.  The Damn algorithm uses a specific
# 10x10 matrix, and a very simple validation algorithm (and the check
# digit validation algorithm is almost identical to the validation algorithm)
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
die "Usage: vaidate-damm [--debug] N\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV==1;

my $n = shift;

my @mat = (
 [ qw(0  3  1  7  5  9  8  6  4  2) ],
 [ qw(7  0  9  2  1  5  4  8  6  3) ],
 [ qw(4  2  0  6  8  7  1  3  5  9) ],
 [ qw(1  7  5  0  9  8  3  4  2  6) ],
 [ qw(6  1  2  3  0  4  5  9  7  8) ],
 [ qw(3  6  7  4  2  0  9  5  8  1) ],
 [ qw(5  8  6  9  7  2  0  1  3  4) ],
 [ qw(8  9  4  5  3  6  2  0  1  7) ],
 [ qw(9  4  3  8  6  1  7  2  0  5) ],
 [ qw(2  5  8  1  4  3  6  7  9  0) ],
);

my $id = 0;	# "interim digit" from Wikipedia page
foreach my $digit (split(//,$n))
{
	$id = $mat[$id][$digit];
}
say ( ($id==0)? "1" : "0" );
