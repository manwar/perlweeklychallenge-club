#!/usr/bin/perl
# 
# Task 1: Capital Detection
# 
# You are given a string with alphabetic characters only: A..Z and a..z.
# 
# Write a script to find out if the usage of Capital is appropriate if it
# satisfies any of the following rules:
# 
# 1) Only first letter is capital and all others are small.
# 2) Every letter is small.
# 3) Every letter is capital.
# 
# Example 1
# 	Input: $s = 'Perl'
# 	Output: 1
# 
# Example 2
# 	Input: $s = 'TPF'
# 	Output: 1
# 
# Example 3
# 	Input: $s = 'PyThon'
# 	Output: 0
# 
# Example 4
# 	Input: $s = 'raku'
# 	Output: 1
# 
# MY NOTES: very easy.
# 
# GUEST LANGUAGE: As a bonus, I also had a go at translating ch-1.pl
# into C (look in the C directory for the translation)
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;

my $debug=0;
die "Usage: capital-detect [--debug] string\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV==1;

my $str = shift;

=pod

=head2 my $ok = capdetect( $str );

Return 1 iff $str is a good "use of capitals" string as described
above, or return 0 otherwise.

=cut
sub capdetect
{
	my( $str ) = @_;
	return 1 if $str =~ /^[A-Z][a-z]*$/;
	return 1 if $str =~ /^[a-z]+$/;
	return 1 if $str =~ /^[A-Z]+$/;
	return 0;
}


my $ok = capdetect( $str );

say $ok;
