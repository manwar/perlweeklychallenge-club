#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-1.pl
#
#        USAGE: ./ch-1.pl  
#
#  DESCRIPTION:Perl Weekly Challenege 083
#  			   https://perlweeklychallenge.org/
#  			   Task 1 - Words Length
#
#       AUTHOR:Lubos Kolouch
#      CREATED: 10/24/2020 01:26:15 PM
#===============================================================================

use strict;
use warnings;
use Data::Dumper;

sub get_words_length {
	my $words = shift;

	# split on whitespace
	my @split_words = split /\s+/, $words;

	my $total_length;

	# skip the first and the last word
	for my $i (1..scalar @split_words-2) {
		$total_length += length($split_words[$i]);
	}

	return $total_length;
}


use Test::More;

is(get_words_length("The Weekly Challenge"), 6);
is(get_words_length("The purpose of our lives is to be happy"), 23);

done_testing;
