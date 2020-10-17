#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 8201.pl
#
#        USAGE: ./8201.pl A B 
#
#  DESCRIPTION: Display all common divisors of natural numbers A and B
#
# REQUIREMENTS: Params::Util, List::Util
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 17/10/20
#===============================================================================

use strict;
use warnings;

use Params::Util '_POSINT';
use List::Util qw/min none/;

# Validate input
for (@ARGV) {
	die "$_ must be a natural number" unless _POSINT ($_);
}

# Start at highest possible potential divisor
my $i = min (@ARGV);
my @div;

# Iterate downwards to 1
while ($i > 0) {
	push @div, $i if none { $_ % $i } @ARGV;
	$i--;
}

print "@div\n";
