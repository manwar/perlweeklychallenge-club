#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-05-06
use utf8;     # Week 268 - task 2 - Number game
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

number_game(2, 5, 3, 4);
number_game(9, 4, 1, 3, 6, 4, 6, 1);
number_game(1, 2, 2, 3);
number_game(1, 7, 6, 0, 2, 3, 5, 7, 1, 3, 9, 3, 4, 7, 7, 2, 0, 8);

sub number_game {
	
	my ($j, @from, @to);
	
	# sort the input
	@from = sort {$a <=> $b} @_;
	
	# add the input 2 by 2 to the output
	for ($j = 0; $j < @from; $j += 2) {
		push @to, $from[$j + 1], $from[$j];
	}
	
	# show the answer
	say sprintf(qq[\nInput:  \@ints = (%s)], join(', ', @_));
	say sprintf(qq[Output:         (%s)], join(', ', @to));
}
