#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 9202.pl
#
#        USAGE: ./9202.pl A-B C-D [ E-F ] ... [ Y-Z ]
#
#  DESCRIPTION: Given N-1 pairs of sorted, ascending positive ints, merge the
#  range of the Nth pair into the ranges of the others.
#
# REQUIREMENTS: List::Util (Core)
#        NOTES: Validating input left as an exercise :-)
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 21/12/20
#===============================================================================

use strict;
use warnings;
use List::Util 'pairs';

# Input
my @ends = join(' ', @ARGV) =~ /[0-9]+/g;

# Process
my @ranges = merge (@ends);

# Output
print join ', ', map { "($_->[0],$_->[1])" } @ranges;
print "\n";

sub merge {
	my @ends = @_;
	my @new;

	# Split into the constituent parts
	unshift @new, pop @ends for (1, 2);
	my @old = pairs @ends;

	my $started  = 0;
	my $finished = 0;
	while (scalar @old) {
		my $pair = shift @old;

		unless ($started) {
			# Are we after this pair has closed?
			if ($new[0] > $pair->[1]) {
				push @ranges, $pair;
				next;
			}
			# Here we go
			$started = 1;
			if ($new[0] < $pair->[0]) {
				# Are we straddling this pair?
				if ($new[1] >= $pair->[0]) {
					$pair->[0] = $new[0];
				} else {
					push @ranges, \@new, $pair, @old;
					$finished = 1;
					last;
				}
			}
		}
		unless ($finished) {
			my $this = $pair;
			# Pick off more entries until we don't finish after the
			# upper bound
			while (defined ($this) && $new[1] > $this->[1]) {
				$this = shift @old;
			}
			# Are we beyond the very last pair?
			unless (defined $this) {
				$pair->[1] = $new[1];
				push @ranges, $pair;
				$finished = 1;
				last;
			}
			# Do we finish before the next pair starts?
			if ($new[1] < $this->[0]) {
				$pair->[1] = $new[1];
				push @ranges, $pair, $this, @old;
				$finished = 1;
				last;
			}
			# Nothing more to do, just append the rest
			$pair->[1] = $this->[1];
			push @ranges, $pair, @old;
			$finished = 1;
			last;
		}
	}
	# If the target pair is after all the others, just append it.
	push @ranges, [@new] unless $finished;
	return @ranges;
}
