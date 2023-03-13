#!/usr/bin/perl
# 
# Task 1: Keyboard Word
# 
# You are given an array of words.  Write a script to print all the words
# in the given array that can be typed using alphabet on only one row of
# the keyboard.
# 
# Let us assume the keys are arranged as below:
# 
# Row 1: qwertyuiop
# Row 2: asdfghjkl
# Row 3: zxcvbnm
# 
# Example 1
# 
#   Input: @words = ("Hello","Alaska","Dad","Peace")
#   Output: ("Alaska","Dad")
# 
# Example 2
# 
#   Input: @array = ("OMG","Bye")
#   Output: ()
# 
# MY NOTES: very easy.  Lower case each word, then match it against /^[qwertyuiop]+$/ for the first row, similarly regexes for the second and third rows.
# 
# GUEST LANGUAGE: As a bonus, I also had a go at translating ch-1.pl into C
# (look in the C directory for that).  replaced regexes with a custom: match a
# sequence of <these chars:string>.
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;

my $debug=0;
die "Usage: keyboard-word [--debug] word-list\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV>0;

my @list = split( /,/, join(',',@ARGV) );

say "list: ", join(',',@list) if $debug;


#
# my $matched = matchword( $w );
#	Find whether or not $w matches any of the keyboard rows.
#	Return true iff it does.
#
sub matchword
{
	my( $w ) = @_;
	return 1 if /^[qwertyuiop]+$/i;
	return 1 if /^[asdfghjkl]+$/i;
	return 1 if /^[zxcvbnm]+$/i;
	return 0;
}


my @result = grep { matchword($_) } @list;

say "(", join(',', map { qq("$_") } @result), ")";
