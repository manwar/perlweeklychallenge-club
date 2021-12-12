#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 14201.pl
#
#        USAGE: ./14201.pl [ -v ] M N 
#
#  DESCRIPTION: Output total count of divisors of M having last digit N.
#
#      OPTIONS: -v for verbose output
# REQUIREMENTS: Getopt::Long::Modern, Params::Util
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 06/12/21
#===============================================================================

use strict;
use warnings;
use Getopt::Long::Modern;
use Params::Util '_POSINT';

my ($m, $n, $verbose) = get_args ();

my @div = (1, $m);
my $j = int sqrt $m;
while ($j > 1) {
	unless ($m % $j) {
		my $q = $m / $j;
		push @div, $j;
		push @div, $q unless $q == $j;
	}
	$j--;
}
print "Divisors of $m are: (@div)\n" if $verbose;
@div = grep { /$n$/ } @div;
print "Divisors ending in $n are: (@div)\nResult is " if $verbose;
print scalar @div . "\n";

sub get_args {
	GetOptions ('v' => \my $v);
	2 == @ARGV or die "Two positive integer arguments required.\n";
	my ($M, $N) = @ARGV;
	_POSINT ($_) or die "'$_' is not a positive integer" for $M, $N;
	$N < 10 or die "'$N' is not a single digit";
	return ($M, $N, $v)
}
