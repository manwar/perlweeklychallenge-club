#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 9002.pl
#
#        USAGE: ./9002.pl [-q] N M
#
#  DESCRIPTION: Ethiopian multiplication showing working out.
#
#      OPTIONS: -q to hide working out
# REQUIREMENTS: Getopt::Std
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 07/12/20
#===============================================================================

use strict;
use warnings;

use Getopt::Std;
$Getopt::Std::STANDARD_HELP_VERSION = 1;
*HELP_MESSAGE = \&usage;
our $VERSION = '1.00';

# Get option
my %opts;
getopts ('q', \%opts) or usage ();

# Validate arguments
my ($n, $m) = @ARGV;
for ($n, $m) {
	usage () unless defined && /^[0-9]+$/ && $_ >= 1;
}

# Process the multiplication
verbose ("Starting with $n and $m we iterate by halving and doubling\n");

my $tot     = 0;
my $target  = $n * $m;
my $prodstr = "$n * $m";

while (1) {
	verbose (sprintf "%5i, %5i\n", $n, $m);
	if ($n % 2) {
		$tot += $m;
		verbose ("  $n is odd so add this value of $m " .
			"to give a running total of $tot\n");
	} else {
		verbose ("  $n is even so ignore this value of $m\n");

	}
	if ($n == 1) {
		verbose ("  n is $n, so we are finished and the result is $tot\n");
		print "$prodstr = $tot\n";
		if ($target != $tot) {
			die q#Hey, wait just a minute. That's not right, # .
				"it should be $tot.\n" .
				"You've managed to break Ethiopian Multiplication!\n";
		}
		exit;
	}
	$n = int ($n / 2);
	$m *= 2;
}

sub usage {
	die <<EOT;
Usage: $0 [ -q ] N M

	where N and M must be natural numbers.
	-q enables quiet mode

EOT
}

sub verbose { print shift unless $opts{q} }
