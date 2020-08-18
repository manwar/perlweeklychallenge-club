#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-2.pl
#
#        USAGE: ./ch-2.pl  
#
#  DESCRIPTION: https://perlweeklychallenge.org/blog/perl-weekly-challenge-073/
#	
#				Smallest Neighbour
#
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Lubos Kolouch
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 16.8.2020 13:40
#     REVISION: ---
#===============================================================================

use strict;
use warnings;

sub get_smallest {
   my $a_ref = shift;

   my @return_array = 0;
   my $min = @$a_ref[0];

   for my $i (1 .. scalar @$a_ref-1) {

	   if ($min < $a_ref->[$i]) {
		   push @return_array, $min;
	   } else {
		   push @return_array, 0;
	   }

	   $min = $a_ref->[$i] if @$a_ref[$i] < $min;

   }

   return \@return_array;
}

# TESTS

use Test::More;

is_deeply(\get_smallest([7, 8, 3, 12, 10]),\[0, 7, 0, 3, 3]);
is_deeply(\get_smallest([4, 6, 5]),\[0, 4, 4]);

done_testing;
