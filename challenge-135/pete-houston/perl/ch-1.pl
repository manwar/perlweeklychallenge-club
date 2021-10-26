#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 13501.pl
#
#        USAGE: ./13501.pl N [ N ... ] 
#
#  DESCRIPTION: Print the middle 3 digits of each given integer
#
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 18/10/21
#===============================================================================

use strict;
use warnings;

for (@ARGV) {
	s/^-//;
	if (/([^0-9])/)   { print "Not an integer because of '$1'\n"; next; }
	my $len = length;
	if ($len < 3)     { print "Too few digits to extract 3\n";    next; }
	unless ($len % 2) { print "Even number of digits\n";          next; }
	print substr ($_, ($len - 3) / 2, 3) . "\n";
}
