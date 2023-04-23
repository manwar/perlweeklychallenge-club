#!/usr/bin/perl
# 
# Task 1: Fun Sort
# 
# You are given a list of positive integers.  Write a script to sort the
# all even integers first then all odds in ascending order.
# 
# Example 1
# 
#   Input: @list = (1,2,3,4,5,6)
#   Output: (2,4,6,1,3,5)
# 
# Example 2
# 
#   Input: @list = (1,2)
#   Output: (2,1)
# 
# Example 3
# 
#   Input: @list = (1)
#   Output: (1)
# 
# MY NOTES: sounds very easy.  Select evens; sort them; select odds; sort them,
# then append sorted lists together.
# 
# GUEST LANGUAGE: As a bonus, I've had a go at translating ch-2.pl into C,
# look in the C/ directory for that.
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;
use List::Util qw(any);

my $debug=0;
die "Usage: fun-sort [--debug] intlist\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV>0;

my @list = split( /,/, join(',',@ARGV) );

say "debug: list: ", join(',',@list) if $debug;

my @even = grep { $_ % 2 == 0 } @list;
my @odd = grep { $_ % 2 == 1 } @list;

@list = sort(@even);
push @list, sort(@odd);

say join(',',@list);
