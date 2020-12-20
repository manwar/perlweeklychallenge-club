#!/usr/bin/perl
#
# Task 1: "Count Number
# 
# You are given a positive number $N.  Write a script to count number and display as you read it.
# 
# Example 1:
# 
# Input: $N = 1122234
# Output: 21321314
# 
# as we read "two 1 three 2 one 3 one 4"
# 
# Example 2:
# 
# Input: $N = 2333445
# Output: 12332415
# 
# as we read "one 2 three 3 two 4 one 5"
# 
# Example 3:
# 
# Input: $N = 12345
# Output: 1112131415
# 
# as we read "one 1 one 2 one 3 one 4 one 5"
# "
# 
# My notes: not brilliantly clearly defined, but simple to do with a freq hash.
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;

my $debug = 0;
die "Usage: count-number [--debug] N\n" unless
	GetOptions( "debug" => \$debug ) &&
	@ARGV==1;
my $n = shift;

my %freq;
foreach my $digit (split(//,$n))
{
	$freq{$digit}++;
}
say "debug: ". Dumper(\%freq) if $debug;
print "$freq{$_}$_" for sort { $a cmp $b } keys %freq;
say "";
