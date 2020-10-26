#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-2.pl
#
#        USAGE: ./ch-2.pl  
#
#  DESCRIPTION:Perl Weekly Challenege 083
#  			   https://perlweeklychallenge.org/
#  			   Task 2 - Flip Array
#
#       AUTHOR:Lubos Kolouch
#      CREATED: 10/25/2020 01:26:15 PM
#===============================================================================

use strict;
use warnings;
use Data::Dumper;
use List::Util qw/sum/;

sub get_nr_flips {

	my $arr = shift;

	# split the array into two sets, using the heuristic algorithm, which may
	# not be perfect, but runs fast!
	
	my @a = [];
	my @b = [];

	for my $i (sort {$b <=> $a} @$arr) {
		if (sum(@a) < sum(@b)) {
			push @a, $i;
		} else { 
			push @b, $i;
		}
	}

	# now flip the smaller list
	return scalar @a if scalar @a < scalar @b;

	return scalar @b;

}



use Test::More;

is(get_nr_flips([3,10,8]), 1);
is(get_nr_flips([2,12,10]), 1);

done_testing;
