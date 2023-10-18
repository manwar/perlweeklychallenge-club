#!/usr/bin/perl

use v5.16;    # The Weekly Challenge - 2023-10-16
use utf8;     # Week 239 task 1 - Same string
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

same_string(['ab', 'c'], ['a', 'bc']);
same_string(['ac', 'b'], ['a', 'bc']);
same_string(['the', 'cat', 'sat', 'on', 'the', 'mat'], ['thec', 'atsa', 'tont', 'hema', 't']);
same_string(['the', 'cat', 'sat', 'on', 'the', 'mat'], ['the', 'dog', 'sat', 'on', 'the', 'rug']);

sub same_string {
	
	# show input
	say qq[\nInput:  \@arr1 = ('] . join(q[', '], @{$_[0]}) . q[')];
	say qq[        \@arr2 = ('] . join(q[', '], @{$_[1]}) . q[')];
	
	# show output by comparing the joins of the 2 arrays
	say qq[Output: ] . (join('', @{$_[0]}) eq join('', @{$_[1]}) ? 'true' : 'false');
}
	