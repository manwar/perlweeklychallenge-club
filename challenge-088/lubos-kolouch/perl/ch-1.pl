#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-1.pl
#
#        USAGE: ./ch-1.pl  
#
#  DESCRIPTION: https://perlweeklychallenge.org/blog/perl-weekly-challenge-088/
#  				Task 1
#  				Array of Product
#
#       AUTHOR: Lubos Kolouch 
#      VERSION: 1.0
#      CREATED: 11/28/2020 01:02:17 PM
#===============================================================================

use strict;
use warnings;
use List::Util qw/product/;

sub get_product{
	my $in_arr = shift;

	my $product = product(@$in_arr);

	my @out_arr;

	push @out_arr, int($product / $_) for (@$in_arr);

	return \@out_arr;
}

use Test::More;

is_deeply(get_product([5, 2, 1, 4, 3]), [24, 60, 120, 30, 40]);
is_deeply(get_product([2, 1, 4, 3]), [12, 24, 6, 8]);

done_testing();
