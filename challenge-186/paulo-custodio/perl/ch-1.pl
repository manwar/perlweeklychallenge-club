#!/usr/bin/perl

# Challenge 186
#
# Task 1: Zip List
# Submitted by: Mohammad S Anwar
#
# You are given two list @a and @b of same size.
#
# Create a subroutine sub zip(@a, @b) that merge the two list as shown in the
# example below.
# Example
#
# Input:  @a = qw/1 2 3/; @b = qw/a b c/;
# Output: zip(@a, @b) should return qw/1 a 2 b 3 c/;
#         zip(@b, @a) should return qw/a 1 b 2 c 3/;

use Modern::Perl;
use List::Util qw( unpairs zip );

@ARGV==2 or die "usage: ch-1.pl list1 list2\n";
say join " ", unpairs(zip(map {[split ' ', $_]} @ARGV));
