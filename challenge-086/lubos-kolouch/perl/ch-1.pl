#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-1.pl
#
#        USAGE: ./ch-1.pl  
#
#  DESCRIPTION: Perl Weekly Challenge 086
#  				Task 1
#  				Pair Difference 
#
#       AUTHOR: Lubos Kolouch
#      CREATED: 11/14/2020 01:27:06 PM
#===============================================================================

use strict;
use warnings;
use Data::Dumper;

sub is_pair_difference {
    my $data = shift;

    # to avoid sorting and/or scanning through all pairs in the array
    # or double nested loop,
    # I will convert the array to a hash and check while creating it
    
    my $arr = $$data{n};
    my %h;
    for (@$arr) {
		$h{$_} = 1;

        return 1 if ($h{$_ + $$data{a}}) or ($h{$_ - $$data{a}}); 
	}

    return 0;
}

use Test::More;

is(is_pair_difference( { 'n' => [10, 8, 12, 15, 5], 'a' => 7 }), 1);
is(is_pair_difference( { 'n' => [1, 5, 2, 9, 7], 'a' => 6 }), 1);
is(is_pair_difference( { 'n' => [10, 30, 20, 50, 40], 'a' => 15 }), 0);

done_testing;

