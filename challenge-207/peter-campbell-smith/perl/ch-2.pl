#!/usr/bin/perl

# Peter Campbell Smith - 2023-02-20

use v5.28;
use utf8;
use warnings;

# We are given a list of the number of citations a researcher has received 
# for each of his published papers, ordered from most cited to least.
# We are asked to write a script to compute the researcher’s H-index, which is the maximum n
# where the n'th number in the list is at least n.

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge/207/2

h_index(10, 8, 5, 4, 3);
h_index(25, 8, 5, 3, 3);
h_index(10, 9, 8, 7, 6, 5, 4, 3, 2, 1);
h_index(0);
h_index();
h_index(4, 4, 4, 4);

sub h_index {
	
	my (@list, $j);
	
	# loop over list (0-based!) to find first where n'th number in list < $n
	@list = @_;
	for ($j = 0; $j < scalar @list; $j ++) {
		last unless $list[$j] >= $j + 1;
	}
	say qq[\nInput:  \@citations = (] . join(', ', @list) . 
		qq[)\nOutput: $j];
}
