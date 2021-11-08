#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 13001.pl
#
#        USAGE: ./13001.pl N [ N ... ]
#
#  DESCRIPTION: Output the one argument which appears an odd number of
#               times.
#
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 13/09/21
#===============================================================================

use strict;
use warnings;

my %freq;
# Count up the occurrences of each positive integer
$freq{$_}++ for map { s/[^0-9]+//g; $_ } @ARGV;
# Remove the entry for bad data, if present
delete $freq{''};
# Extract those integers with odd frequencies
my @odds = grep { $freq{$_} % 2 } keys %freq;

if ($#odds < 0) {
	die "No arguments occurred an odd number of times.\n";
} elsif ($#odds > 0) {
	die "More than one argument occurred an odd number of times.\n";
} else {
	print "$odds[0]\n";
}
