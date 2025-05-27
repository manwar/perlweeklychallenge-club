#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-05-26
use utf8;     # Week 323 - task 1 - Increment decrement
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

increment_decrement('--x', 'x++', 'x++');
increment_decrement('x++', '++x', 'x++');
increment_decrement('x++', '++x', '--x', 'x--');

sub increment_decrement {
	
	my (@operations, $result);
	
	# initialise
	@operations = @_;
	
	# assumw they are all negative
	$result = -@operations;
	
	# add 2 for each positive one
	$result += 2 for grep(/\+/, @operations);	
	
	say qq[\nInput:  ('] . join(q[', '], @operations) . q[')];
	say qq[Output: $result];
}
