#!/usr/bin/perl
#
# Task 2: "Lines Range
# 
# You are given a text file name $file and range $A - $B where $A <= $B.
# 
# Write a script to display lines range $A and $B in the given file.
#
# Example
# Input:
#    $ cat input.txt
#    L1
#    L2
#    L3
#    L4
#    ...
#    ...
#    L100
#
# $A = 4 and $B = 12
#
# Output:
#
#    L4
#    L5
#    L6
#    ...
#    L10
#    L11
#    L12
# "
#
# My notes: ok.  Seems even easier.  I/O and a line number count (let's use $.)
#
 

use strict;
use warnings;
use feature 'say';
#use Function::Parameters;
#use Data::Dumper;

die "Usage: line-range FROM TO [filename]\n" unless @ARGV==2 || @ARGV==3;
my $from = shift;
my $to = shift;

die "line-range: 1 <= FROM <= TO ($from..$to given)\n"
	unless $from>=1 && $to>=$from;

while( <> )
{
	print if $. >= $from && $. <= $to;
}
