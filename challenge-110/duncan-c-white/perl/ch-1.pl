#!/usr/bin/perl
# 
# Task 1: "Valid Phone Numbers
# 
# You are given a text file.
# 
# Write a script to display all valid phone numbers in the given text file.
# Acceptable Phone Number Formats
# 
# +nn  nnnnnnnnnn
# (nn) nnnnnnnnnn
# nnnn nnnnnnnnnn
# 
# Input File
# 
# 0044 1148820341
#  +44 1148820341
#   44-11-4882-0341
# (44) 1148820341
#   00 1148820341
# 
# Output
# 
# 0044 1148820341
#  +44 1148820341
# (44) 1148820341
# "
# 
# My notes: as the valid formats are fixed, just a load of regexes.
# Would have been more interesting if the formats were inputs too.
#

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
#use Data::Dumper;


#
# my $isvalid = validno($line);
#	Return 1 iff $line contains a valid phone no.
#	0 otherwise.
#
fun validno( $line )
{
	$line =~ s/^\s+//;
	$line =~ s/\s+$//;
	return 1 if $line =~ /^\+\d\d\s+\d{10}$/;
	return 1 if $line =~ /^\(\d\d\)\s+\d{10}$/;
	return 1 if $line =~ /^\d{4}\s+\d{10}$/;
	return 0;
}


die "Usage: phone-numbers\n" unless @ARGV==0;


while( <> )
{
	print if validno($_);
}
