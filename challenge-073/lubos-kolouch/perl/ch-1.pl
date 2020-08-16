#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-1.pl
#
#        USAGE: ./ch-1.pl  
#
#  DESCRIPTION: https://perlweeklychallenge.org/blog/perl-weekly-challenge-073/
#	
#				Min Sliding Window
#
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Lubos Kolouch
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 16.8.2020 12:40
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use List::Util qw/min/;

sub min_window {
   my ($a_ref, $s) = @_;

   my @return_array;

   my $pos = 0;
   while (1) {
	   my $last_index = min(scalar @$a_ref-1, $pos+$s);

	   push @return_array, min(@$a_ref[$pos..$last_index]);
	   last if $last_index == scalar(@$a_ref)-1;

	   $pos++;
   }

   return \@return_array;
}


# TESTS

use Test::More;

is_deeply(\min_window([1, 5, 0, 2, 9, 3, 7, 6, 4, 8],3),\[0,0,0,2,3,3,4]);
is_deeply(\min_window([1, 2, 3],4),\[1]);

done_testing;
