#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 13101.pl
#
#        USAGE: ./13101.pl N [ N ... ] 
#
#  DESCRIPTION: Output the positive integers grouped as consecutive lists
#
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 20/09/21
#===============================================================================

use strict;
use warnings;

my @out;
print '(';
for my $n (map { s/[^0-9]//; $_ } @ARGV) {
	if ($#out == -1 || $n == $out[-1] + 1) {
		push @out, $n;
	} else {
		print '[' . join (', ', @out) . '], ';
		@out = $n;
	}
}
print '[' . join (', ', @out) . "])\n";
