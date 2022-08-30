#!/usr/bin/env perl 
#
# Task 2: Trim List
# 	You are given list of numbers, @n and an integer $i.
#	Write a script to trim the given list where element is less than or equal to the given integer.
#
#	./TWC-180-c2.pl 1,2,3,4,1,10,16,23,25,37,45 16
#		Filtered list is: 23,25,37,45 

use strict;
use warnings;

die "Missing mandatory arg!\n" unless (defined $ARGV[0] and defined $ARGV[1]);

my @List = split(/,/, $ARGV[0]);
my $Int = $ARGV[1];
my @Filtered;

foreach (@List) { push(@Filtered, $_) unless $_ <= $Int; }

$"=',';
print ("Filtered list is: @Filtered \n");
