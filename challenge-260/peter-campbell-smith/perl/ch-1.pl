#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-03-11
use utf8;     # Week 260 - task 1 - Unique occurrences
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

unique_occurrences(1, 2, 2, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 5);
unique_occurrences(1, 2, 2, 3, 3, 3, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5);
unique_occurrences(1, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 5, 5);

my (@ints, $j);
for $j (0 .. 99) {
	$ints[$j] = int(rand(21) - 10);
}
unique_occurrences(@ints);

sub unique_occurrences {
	
	my (@ints, %occurs, $output, $reason, $value, %seen);
	
	# initialise
	@ints = @_;
	$output = 1;
	$reason = '';
	say qq[\nInput: \@ints = (] . join(', ', @ints) . ')';
	
	# count occurrences
	$occurs{$_} ++ for @ints;
	
	# see if they are all 1
	for $value (keys %occurs) {
		if (defined $seen{$occurs{$value}}) {
			$output = 0;
			$reason = qq[($value and $seen{$occurs{$value}} both occur $occurs{$value} times)];
			last;
		}			
		$seen{$occurs{$value}} = $value;
	}
	
	# show the answer
	say qq[Output: $output $reason];
}	
