#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 10602.pl
#
#        USAGE: ./10602.pl NUMERATOR DENOMINATOR
#
#  DESCRIPTION: Print decimal quotient with bracketed recurrences
#
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 29/03/21
#===============================================================================

use strict;
use warnings;

my ($n, $d) = @ARGV;
die "Infinity\n" unless $d;
my $q = '' . ($n / $d);

# Look for recurrences in the fractional part
my ($int, $dec) = split /\./, $q;
my $maxlen = length ($dec);
my @recur;

OUTER: for my $charno (1 .. int ($maxlen / 2)) {
	for my $init (0 .. $charno - 1) {
		my $pos   = $init;
		my $reps  = 0;
		my $start = $pos;
		my $pat   = substr ($dec, $pos, $charno);
		while ($pos < $maxlen - 2 * $charno) {
			$pos += $charno;
			my $next = substr ($dec, $pos, $charno);
			if ($next eq $pat) {
				$reps++;
			} else {
				$pat = $next;
				$start = $pos;
				$reps = 0;
			}
		}
		if ($reps) {
			push @recur, { start => $start, reps => $reps, pat => $pat };
		}	
	}
}

if (1 < @recur) {
	@recur = sort {
		$a->{start} <=> $b->{start}
		||
		$b->{reps} <=> $a->{reps}
	} @recur;
}
if (@recur) {
	$dec = substr ($dec, 0, $recur[0]->{start}) . "($recur[0]->{pat})";
	
}
print "$int.$dec\n";
