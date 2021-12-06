#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 14101.pl
#
#        USAGE: ./14101.pl [ -v ] [ -d N ] [ -n COUNT ]
#
#  DESCRIPTION: Print the 10 lowest positive integers having exactly 8
#               divisors.
#
#      OPTIONS: -v for verbose output
#      OPTIONS: -d to set the number of divisors [ default is 8 ]
#      OPTIONS: -n to set the number of integers found [ default is 10 ]
# REQUIREMENTS: Getopt::Long::Modern
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 29/11/21
#===============================================================================

use strict;
use warnings;
use Getopt::Long::Modern;

my $divno = 8;
my $max   = 10;
GetOptions (
	'v' => \my $verbose,
	'd=i' => \$divno,
	'n=i' => \$max,
);

print "The first $max positive integers having exactly $divno divisors:\n"
	if $verbose;

my $found = 0;
my $i     = 1; # By inspection this could be 24

while ($found < $max) {
	my @div = (1, $i);
	my $j = int sqrt $i;
	while ($j > 1) {
		unless ($i % $j) {
			my $q = $i / $j;
			push @div, $j;
			push @div, $q unless $q == $j;
		}
		$j--;
	}
	if ($divno == @div) {
		print "$i\n";
		print "  Divisors are: (@div)\n" if $verbose;
		$found++;
	}
	$i++;
}
