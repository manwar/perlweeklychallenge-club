#!/usr/bin/perl
#
# Task 1: "Compare Version
#
# Compare two given version number strings v1 and v2 such that:
# 
#     If v1 > v2 return 1
#     If v1 < v2 return -1
#     Otherwise, return 0
# 
# The version numbers are non-empty strings containing only digits, the dot
# ('.') and underscore ('_') characters. ('_' denotes an alpha/development
# version, and has a lower precedence than a dot, '.'). Here are some examples:
# 
#    v1   v2    Result
# ------ ------ ------
#   0.1 < 1.1     -1
#   2.0 > 1.2      1
#   1.2 < 1.2_5   -1
# 1.2.1 > 1.2_1    1
# 1.2.1 = 1.2.1    0
# 
# Version numbers may also contain leading zeros. You may handle these
# how you wish, as long as it's consistent.
# "
# 
# My notes: I hate version numbers already:-)  but it doesn't sound too hard.
# I am assuming there can be any number of '.'s, but one zero or one '_'
# inside each '.'-separated component.  eg 1.2_2_2 isn't valid.
#

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
use List::Util qw(max);
use Data::Dumper;



die "Usage: compare-versions v1 v2\n" unless @ARGV==2;
my( $v1, $v2 ) = @ARGV;


#
# my $result = validate_version( $v );
#	Validate a version string $v according to
#	the rules described at the top.  Return 1 if $v is valid,
#	-1 otherwise.
#
fun validate_version( $v )
{
	my $origv = $v;

	$v =~ s/^0+//;		# remove any leading zeroes

	while( $v )
	{
		$v =~ s/^\d+// || return 0;
		return 1 unless $v;

		# deal with optional underscore
		if( $v =~ s/^_// )
		{
			$v =~ s/^\d+// || return 0;
		}

		return 1 unless $v;

		# deal with compulsory '.'
		return 0 unless $v =~ s/^\.//;
	}

	return 1;
}


#
# my $result = compare_versions( $v1, $v2 );
#	Compare two VALID version strings $v1 and $v2, according to
#	the rules described at the top.  Return -1 if $v1 < $v2,
#	1 if $v1 > $v2 and 0 if $v1 == $v2.  Don't bother to check validity
#	as you go, told both versions ARE valid.
#
fun compare_versions( $v1, $v2 )
{
	my $origv1 = $v1;
	my $origv2 = $v2;

	$v1 =~ s/^0+//;		# remove any leading zeroes
	$v2 =~ s/^0+//;

	while( 1 )
	{
		# both must have leading digit sequence
		$v1 =~ s/^(\d+)//; my $c = $1;
		$v2 =~ s/^(\d+)//; my $d = $1;

		return -1 if $c < $d;	# leading numeric part of v1 smaller
		return 1 if $c > $d;	# leading numeric part of v1 larger

		# same leading number:-)

		# deal with optional underscores
		if( $v1 =~ /^_/ && $v2 =~ /^_/ )
		{
			# both have _.. check and compare
			$v1 =~ s/^_//;
			$v2 =~ s/^_//;

			# both must have leading digit sequence: compare them

			$v1 =~ s/^(\d+)//; my $c = $1;
			$v2 =~ s/^(\d+)//; my $d = $1;

			return -1 if $c < $d;	# _N part of v1 smaller
			return 1 if $c > $d;	# _N part of v1 larger
		} elsif( $v1 =~ /^_/ )
		{
			return 1;
		} elsif( $v2 =~ /^_/ )
		{
			return -1;
		}

		# might be end, or could have '.'
		return 0 if $v2 eq '' && $v1 eq '';

		# deal with optional '.'
		if( $v1 =~ /^\./ && $v2 =~ /^\./ )
		{
			# both have '.', check and compare
			$v1 =~ s/^\.//;
			$v2 =~ s/^\.//;

			# continue at top of while loop

		} elsif( $v1 =~ /^\./ )
		{
			return 1;		# v2 ended
		} elsif( $v2 =~ /^\./ )
		{
			return -1;		# v1 ended
		}
	}

	# never reached
}

die "v1 $v1 is invalid\n" unless validate_version($v1);
die "v2 $v2 is invalid\n" unless validate_version($v2);

my $result = compare_versions( $v1, $v2 );
print "$v1 is less than $v2\n" if $result == -1;
print "$v1 is greater than $v2\n" if $result == 1;
print "$v1 is same as $v2\n" if $result == 0;
