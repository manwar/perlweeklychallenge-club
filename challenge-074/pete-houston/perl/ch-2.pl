#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 7402.pl
#
#        USAGE: ./7402.pl STRING [ STRING ... ]
#
#  DESCRIPTION: For each string print the list of last non-repeating
#  characters up to that point (using # if none)
#
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 23/08/20
#===============================================================================

use strict;
use warnings;
use 5.010;

sub fnr {
	# Given a string, return a string of last non-repeating chars for
	# the substrings up to incrementing positions.
	my $in = shift;
	my (%seen, @sorted, @fnr);
	for my $char (split //, $in) {
		unless (exists $seen{$char}) {
			$seen{$char} = 1;
			unshift @sorted, $char;
			push @fnr, $char;
		} elsif ($seen{$char} > 1) {
			push @fnr, $fnr[-1];
		} else {
			$seen{$char}++;
			my ($this) = grep { $seen{$_} == 1; } @sorted;
			push @fnr, $this // '#';
		}
	}
	return join '', @fnr;
}

for my $str (@ARGV) {
	my $fnr = fnr ($str);
	print "FNR for '$str' is $fnr\n";
}
