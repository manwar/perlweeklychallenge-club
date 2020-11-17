#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 8601.pl
#
#        USAGE: ./8601.pl A N N [ ... ]
#
#  DESCRIPTION: Determine if any pair of N have a difference of A
#
#        NOTES: Displays the matching difference, if any
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 09/11/20
#===============================================================================

use strict;
use warnings;

my $diff = shift @ARGV;
my %lookup = map { $_ => 1 } @ARGV;

my ($res) = grep { $lookup{$_ + $diff} } @ARGV;
if (defined $res) {
	print $res + $diff . " - $res = $diff\n1\n";
} else {
	print "0\n";
}
