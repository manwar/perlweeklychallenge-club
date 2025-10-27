#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-10-27
use utf8;     # Week 345 - task 2 - Last visitor
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

last_visitor(5, -1, -1);
last_visitor(3, 7, -1, -1, -1);
last_visitor(2, -1, 4, -1, -1);
last_visitor(10, 20, -1, 30, -1, -1);
last_visitor(-1, -1, 5, -1);

sub last_visitor {
	
	my (@ints, @ans, @seen, $i, $x);
	
	# initialise
	@ints = @_;
	$x = 0;
	
	for $i (0 .. $#ints) {
		
		# if $ints[i] is +ve push it onto @seen
		if ($ints[$i] > 0) {
			push @seen, $ints[$i];
			$x = 0;

		# if $ints[$i] is -1 ...
		} elsif ($ints[$i] == -1) {
			
			# ... and $x <= length of @seen
			if ($x <= $#seen) {
				
				# push $x'th from last element of @seen onto @ans 
				push @ans, $seen[$#seen - $x];			
			} else {
				
				#  else push -1 onto @ans
				push @ans, -1;
			}
			
			# increment no of consecutive -1s
			$x ++;
		}
	}
	say qq[\nInput:  (] . join(', ', @ints) . ')';
	say qq[Output: (] . join(', ', @ans) . ')';
}
