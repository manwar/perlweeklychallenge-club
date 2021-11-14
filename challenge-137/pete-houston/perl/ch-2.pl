#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 13702.pl
#
#        USAGE: ./13702.pl [-v] N
#
#  DESCRIPTION: Print 1 if N is a Lychrel number, 0 otherwise 
#
#      OPTIONS: -v gives verbose output
# REQUIREMENTS: Getopt::Long::Modern
#        NOTES: Values of $maxn and $maxiter are as specified in the task
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 01/11/21
#===============================================================================

use strict;
use warnings;
use Getopt::Long::Modern;

GetOptions (v => \my $verbose);

my $maxn     = 10_000_000;
my $maxiter  = 500;
my $n        = shift;

die "Bad argument: must be integer between 10 and 1000 inclusive.\n"
	unless defined ($n) && $n =~ /^[1-9][0-9]{1,3}$/;

for (1..$maxiter) {
	my $rev = reverse $n;
	if ($rev eq $n) { print "0\n"; exit; }
	print "$n + $rev = " if $verbose;
	$n += $rev;
	print "$n\n" if $verbose;
	if ($n > $maxn) { print "1 (Total of $n is above $maxn)\n"; exit; }
}
print "1 (Reached $maxiter iterations)\n";
