#!/usr/bin/perl
# 
# Task 1: Sequence Number
# 
# You are given list of strings in the format aa9999 i.e. first 2 characters
# can be anything 'a-z' followed by 4 digits '0-9'.
# Write a script to replace the first two characters with sequence starting
# with '00', '01', '02' etc.
# 
# Example 1
# 
# 	Input: @list = ( 'ab1234', 'cd5678', 'ef1342')
# 	Output: ('001234', '015678', '021342')
# 
# Example 2
# 
# 	Input: @list = ( 'pq1122', 'rs3334')
# 	Output: ('001122', '013334')
# 
# MY NOTES: nice and easy. Trivial in fact.
# 
# GUEST LANGUAGE: As a bonus, I also had a go at implementing ch-1.pl
# into C (look in the C directory for that).
# 

use strict;
use warnings;
use feature 'say';
use feature 'state';
use Getopt::Long;
use Data::Dumper;


my $debug=0;
die "Usage: sequence-number [--debug] string+\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV>0;

#
# my $seqstr = seqno( $str );
#	Given a string in the format aa9999 i.e. first 2 characters
#	can be anything 'a-z' followed by 4 digits '0-9', 
#	replace the first two characters with sequence starting
#	with '00', '01', '02' etc.
#
sub seqno
{
	my( $str ) = @_;
	state $seqno = 0;
	die "bad format $str: not lldddd\n" unless $str =~ /^(\w\w)(\d\d\d\d)$/;
	$str = sprintf( "%02d%s", $seqno++, $2 );
	return $str;
}


my @list = @ARGV;

say join( ',', map { seqno($_) } @list );
