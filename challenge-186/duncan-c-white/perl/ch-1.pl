#!/usr/bin/perl
# 
# Task 1: Zip List
# 
# You are given two list @a and @b of same size.
# Create a subroutine sub zip(@a, @b) that merge the two list as shown in
# the example below.
# 
# Example
# 
# Input:  @a = qw/1 2 3/; @b = qw/a b c/;
# Output: zip(@a, @b) should return qw/1 a 2 b 3 c/;
#         zip(@b, @a) should return qw/a 1 b 2 c 3/;
# 
# 
# MY NOTES: very easy, except for the fact that a Perl subroutine CAN'T
# take 2 arrays.  Guess he meant array-refs?
# 
# GUEST LANGUAGE: As a bonus, I also had a go at translating ch-1.pl
# into C (look in the C directory for that).  Of course, that could
# only deal with lists of integers, so the examples above have to change.
# 

use strict;
use warnings;
use feature 'say';
use feature 'state';
use Getopt::Long;
use Data::Dumper;


my $debug=0;
die "Usage: zip [--debug] csvlist1 csvlist2\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV==2;

=pod

=head2 my @zipped = zip( \@a, \@b );

Take two references to lists, ideally of the same length,
and zip them together as the task comment describes.
Return the single zipped array.

=cut
sub zip
{
	my( $aref, $bref ) = @_;
	my @result;
	while( @$aref && @$bref )
	{
		my $one = shift @$aref;
		my $two = shift @$bref;
		push @result, $one, $two;
	}
	# at this point, zero or one of the arrays are non-empty..
	# append any non-empty list by appending both:-)
	push @result, @$aref;
	push @result, @$bref;
	return @result;
}


my( $one, $two ) = @ARGV;
my @one = split( /,/, $one );
my @two = split( /,/, $two );
say join( ',', zip( \@one, \@two ) );
