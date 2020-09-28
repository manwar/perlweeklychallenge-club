#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 7902.pl
#
#        USAGE: ./7902.pl N ...
#
#  DESCRIPTION: Histogram capacity
#
# REQUIREMENTS: List::Util
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 22/09/20
#===============================================================================

use strict;
use warnings;
use List::Util 'max';

print_histo (@ARGV);
histo_capacity (@ARGV);

sub histo_capacity {
	my @in = @_;
	my $start = shift @in;
	my $capacity = 0;
	while (my $next = shift @in) {
		last unless scalar @in;
		my $max = max (@in);
		$start = $max if $max < $start;
		if ($next < $start) {
			$capacity += $start - $next;
			next;
		}
		$start = $next;
	}
	print "\nCapacity is $capacity\n";
}

sub print_histo {
	my @y = @_;
	my $yval = max (@y);
	while ($yval) {
		printf "\%6i\%s\n",
			$yval, join '', map { $_ >= $yval ? ' #' : '  ' } @y;
		$yval--;
	}
	print ' ' x 4, ' _' x (1 + @y), "\n       @y\n";
}
