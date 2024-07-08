#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-07-08
use utf8;     # Week 277 - task 1 - Count common
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

count_common([qw(the fat cat sat on the mat)], [qw(the loud dog ran on the grass)]);
count_common([qw(You are given two arrays of strings)], [qw(Write a script to return the count)]);
count_common([qw(all good things come to an end)], [qw(end an to come things good all)]);
count_common([qw(one three)], [qw(ONE TWO)]);

sub count_common {
	
	my (@arrays, $j, @singles, %count, $word, $output);
	
	@arrays = @_;
	$output = 0;
	
	# count word frequency	
	for $j (0 .. 1) {
		$count{$_}[$j] ++ for @{$arrays[$j]};
	}
	
	# find ones that occur once in each sentence
	for $word (keys %count) {
		$output ++ if ($count{$word}[0] or 0) == 1 and ($count{$word}[1] or 0) == 1;
	}
	
	printf(qq[\nInput:  \@words1 = '%s'\n        \@words2 = '%s'\n], 
		join(qq[', '], @{$arrays[0]}), join(qq[', '], @{$arrays[1]}));
	say qq[Output: $output];
}
