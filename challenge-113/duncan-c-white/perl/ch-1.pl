#!/usr/bin/perl
# 
# Task 1: "Represent Integer
# 
# You are given a positive integer $N and a digit $D.
# 
# Write a script to check if $N can be represented as a sum of positive
# integers having $D at least once. If check passes print 1 otherwise 0.
# 
# Example
# 
# Input: $N = 25, $D = 7
# Output: 0 as there are 2 numbers between 1 and 25 having the digit 7
# i.e. 7 and 17. If we add up both we don't get 25.
# 
# Input: $N = 24, $D = 7
# Output: 1
# "
# 
# My notes: sounds very simple.  sum ( grep contains 7 )
# 

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
use List::Util qw(sum);
#use Data::Dumper;

die "Usage: lucky7 N D\n" unless @ARGV==2;
my( $n, $d ) = @ARGV;

my $total = sum( grep { /7/ } 1..$n );
my $correct = ($total == $n) ? 1 : 0;

print "total=$total, correct=$correct\n";
