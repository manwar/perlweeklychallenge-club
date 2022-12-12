#!/usr/bin/perl
# 
# Task 1: Digital Clock
# 
# You are given time in the format hh:mm with one missing digit.
# 
# Write a script to find the highest digit between 0-9 that makes it valid time.
# 
# Example 1
# 
# Input: $time = '?5:00'
# Output: 1
# 
# Since 05:00 and 15:00 are valid time and no other digits can fit in the
# missing place.
# 
# Example 2
# 
# Input: $time = '?3:00'
# Output: 2
# 
# Example 3
# 
# Input: $time = '1?:00'
# Output: 9
# 
# Example 4
# 
# Input: $time = '2?:00'
# Output: 3
# 
# Example 5
# 
# Input: $time = '12:?5'
# Output: 5
# 
# Example 6
# 
# Input: $time =  '12:5?'
# Output: 9
# 
# MY NOTES: very easy, most of it is error checking..
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
die "Usage: digital-clock [--debug] hh:mm\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV==1;

my $time = shift;

die "digital-clock: time str $time should be length 5\n"
	unless length($time)==5;

die "digital-clock: bad time str $time\n"
	unless $time =~ /^([(012?])([0-9?]):([0-5?])([0-9?])$/;

my( $h1, $h2, $m1, $m2 ) = ( $1, $2, $3, $4 );

my $tmp = $time;
my $nq = $tmp =~ tr/?//d;
die "digital-clock: need a single '?' in time str $time, not $nq\n"
	unless $nq==1;

die "digital-clock: bad time str $time\n"
	if $h1 eq '2' && $h2 gt '3' && $h2 ne '?';

=pod

=head2 my $result = find_question( $h1, $h2, $m1, $m2 );

Given h1 (the first hour digit 0,1,2 or ?),
h2 (the second hour digit, 0-9 or ?),
m1 (the first minute digit 0-5 or ?) and
m2 (the second minute digit 0-9 or ?),
locate the question mark and find and return the maximum value
that cell could be.  Abort if there's no '?' anywhere.

=cut
sub find_question
{
	my( $h1, $h2, $m1, $m2 ) = @_;
	return ( $h2 gt '3' ) ? 1 : 2 if $h1 eq '?';
	return ( $h1 eq '2' ) ? 3 : 9 if $h2 eq '?';
	return 5 if $m1 eq '?';
	return 9 if $m2 eq '?';
	die "no question mark found in $h1$h2:$m1$m2\n";
}

my $result = find_question( $h1, $h2, $m1, $m2 );
say $result;
