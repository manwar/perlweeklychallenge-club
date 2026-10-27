#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge/397/1

use v5.26;    # The Weekly Challenge - 2026-10-26
use utf8;     # Week 397 - task 1 - Absent smallest positive
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

absent_smallest_positive(1, 2, 4, 5, 6);
absent_smallest_positive(-5, -2, -1, 3);
absent_smallest_positive(1, 2, 3);
absent_smallest_positive(2, 3, 7, 8);
absent_smallest_positive(1, 1, 1, 10);

my @array;
push @array, int(rand(10000)) for 1 .. 500;
absent_smallest_positive(@array);

sub absent_smallest_positive {
	
	my (@array, $total, %present, $answer);
	
	# find total and record presence
	@array = @_;
	for (@array) {
		$total += $_;
		$present{$_} = 1;
	}
	
	# find minimum answer and increment until not present
	$answer = int($total / $#array) + 1;
	$answer = 1 if $answer < 1;
	$answer ++ while $present{$answer};
	
	# report
	say qq[\nInput:  (] . join(', ', @array) . ')';
	say qq[Output: $answer];
}
