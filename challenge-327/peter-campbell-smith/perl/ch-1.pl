#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-06-23
use utf8;     # Week 327 - task 1 - Missing integers
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

missing_integers(1, 2, 1, 3, 2, 5);
missing_integers(1, 1, 1);
missing_integers(2, 2, 1);
missing_integers(7, 8, 9);
missing_integers(5, 5, 5, 5, 5);
missing_integers(5, 4, 3, 2, 1);

sub missing_integers {
	
	my (@ints, @present, @absent);
	
	# initialise
	@ints = @_;
	
	# set $present[$j] to 1 if $j is present in @ints
	$present[$ints[$_]] = defined $ints[$_] ? 1 : 0 for 0 .. $#ints;
	
	# push $j onto @absent if $present[$j] is not defined
	push @absent, grep {not defined $present[$_]} 1 .. scalar @ints;
	
	# report results
	say qq[\nInput:  (] . join(', ', @ints) . q[)];
	say qq[Output: (] . join(', ', @absent) . q[)];
}
