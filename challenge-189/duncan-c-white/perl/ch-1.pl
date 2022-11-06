#!/usr/bin/perl
# 
# Task 1: Greater Character
# 
# You are given an array of characters (a..z) and a target character.
# 
# Write a script to find out the smallest character in the given array
# lexicographically greater than the target character.
# 
# Example 1
# 
# 	Input: @array = qw/e m u g/, $target = 'b'
# 	Output: e
# 
# Example 2
# 
# 	Input: @array = qw/d c e f/, $target = 'a'
# 	Output: c
# 
# Example 3
# 
# 	Input: @array = qw/j a r/, $target = 'o'
# 	Output: r
# 
# Example 4
# 
# 	Input: @array = qw/d c a f/, $target = 'a'
# 	Output: c
# 
# Example 5
# 
# 	Input: @array = qw/t g a l/, $target = 'v'
# 	Output: v
# 
# MY NOTES: pretty easy, although example 5 seems to imply that the spec
# should say, "... or the target if no character in the array is bigger
# than the target".  So that's the basis on which I'm proceeding:
#
# Note that "an array of characters" is awfully like "a string + split",
# so let's do that.
#
# Can do it as a one-liner:
#   perl -MList::Util=minstr -E '( $target, $str ) = @ARGV; $x = minstr( grep { $_ gt $target } split( //, $str ) ) // ($target); say $x' a dcef
# 
# GUEST LANGUAGE: As a bonus, I also had a go at translating ch-1.pl
# into C and Pascal (look in the obvious directories for the translations).
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use List::Util qw(minstr);
use Data::Dumper;

my $debug=0;
die "Usage: gt-chr [--debug] target string\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV==2;

my( $target, $str ) = @ARGV;
my @array = split( //, $str );
my $x = minstr( grep { $_ gt $target } @array ) // $target;
say $x;
