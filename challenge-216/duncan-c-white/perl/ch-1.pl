#!/usr/bin/perl
# 
# Task 1: Registration Number
#  
# You are given a list of words and a random registration number.
# Write a script to find all the words in the given list that has every
# letter in the given registration number.
# 
# Example 1
# 
#   Input: @words = ('abc', 'abcd', 'bcd'), $reg = 'AB1 2CD'
#   Output: ('abcd')
# 
#   The only word that matches every alphabets in the given registration number is 'abcd'.
# 
# Example 2
# 
#   Input: @words = ('job', 'james', 'bjorg'), $reg = '007 JB'
#   Output: ('job', 'bjorg')
# 
# Example 3
# 
#   Input: @words = ('crack', 'road', 'rac'), $reg = 'C7 RA2'
#   Output: ('crack', 'rac')
# 
# MY NOTES: I think the meaning is: form a set of all letters from the
# registration.  Select all words that contain every member of the set.
# That's easy.
# 
# GUEST LANGUAGE: As a bonus, I've had a go at translating ch-1.pl into C,
# look in the C/ directory for that.
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;

my $debug=0;
die "Usage: reg-no [--debug] reg wordlist\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV>1;

my $reg = shift;
my @list = split( /,/, join(',',@ARGV) );

say "debug: reg: $reg, list: ", join(',',@list) if $debug;

#
# my $containsall = wordcontainsall( $word, %set );
#	Return true iff $word contains every letter in %set.
#
sub wordcontainsall
{
	my( $word, %set ) = @_;
	foreach my $letter (keys %set)
	{
		return 0 unless $word =~ /$letter/i;
	}
	return 1;
}


my %regset;
$regset{$_}++ for grep { /[A-Z]/i } split(//,$reg);

#die Dumper(\%regset);

my @results;
foreach my $word (@list)
{
	if( wordcontainsall( $word, %regset ) )
	{
		push @results, $word;
		say "debug: found word $word that contains all reg letters"
			if $debug;
	}
}

say join( ',', map { qq('$_') } @results );
