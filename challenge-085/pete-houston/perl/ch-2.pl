#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 8502.pl
#
#        USAGE: ./8502.pl N
#
#  DESCRIPTION: Determine if whole number N can be expressed as an integer power
#
# REQUIREMENTS: Math::GMP
#        NOTES: Gives details of which root and power match
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 04/11/20
#===============================================================================

use strict;
use warnings;

use Math::GMP;

my $target = Math::GMP->new (shift @ARGV);
for my $power (2 .. $target) {
	my ($root, $rem) = $target->brootrem ($power);
	unless ($rem) {
		print "$root ** $power = $target\n1\n";
		exit;
	}
	last if $root < 2;
}
print "0\n";
