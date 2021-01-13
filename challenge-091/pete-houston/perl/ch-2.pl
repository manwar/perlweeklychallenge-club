#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 9102.pl
#
#        USAGE: ./9102.pl N [ N ] ... 
#
#  DESCRIPTION: Prints 1 if you can reach the end precisely, 0 otherwise
#
#        NOTES: This would be more efficient with one global array and
#               just passing around the indices. I prefer the approach
#               presented here for reasons of code clarity. YMMV.
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 16/12/20
#===============================================================================

use strict;
use warnings;

print 0+solve (@ARGV), "\n";

sub solve {
	my @nodelist = @_;

	# Are we beyond the end?
	return 0 unless defined $nodelist[0];

	# Are we at the end?
	return 1 if $#nodelist == 0;

	# 0 is a tarpit
	return 0 if $nodelist[0] == 0;
	
	# Try the allowed jumps starting with the largest
	for my $step (reverse (1 .. $nodelist[0])) {
		return 1 if solve (@nodelist[$step .. $#nodelist]);
	}
	return 0;
}
