#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 7202.pl
#
#        USAGE: ./7202.pl LINEA LINEB FILE [ FILE ... ]
#
#  DESCRIPTION: Display lines from number A to B inclusive of FILE on STDOUT
#
#        NOTES: Optimised for memory, not speed
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 04/08/20
#===============================================================================

use strict;
use warnings;
use autodie;

my $start = shift @ARGV;
my $end   = shift @ARGV;
print "start = $start, end = $end\n";
for my $file (@ARGV) {
	open my $in, '<', $file;
	<$in> for 2 .. $start;
	print '' . <$in> for ($start .. $end);
	close $in;
}
