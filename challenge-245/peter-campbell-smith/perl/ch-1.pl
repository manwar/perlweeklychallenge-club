#!/usr/bin/perl

use v5.26;    # The Weekly Challenge - 2023-11-27
use utf8;     # Week 245 task 1 - Sort language
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

sort_language(['perl', 'c', 'python'], [2, 1, 3]);
sort_language(['perl', 'fortran', 'algol', 'pascal', 'html', 'apl', 'c++', 'French'],
	[7, 3, 5, 1, 8, 2, 4, 6]);
	
sub sort_language {
	
	my (@languages, @ranks, @order);
	
	@languages = @{$_[0]};
	@ranks = @{$_[1]};
	
	$order[$ranks[$_] - 1] = $languages[$_] for 0 .. @languages - 1;
	
	say qq[\nInput:      \@lang = ('] . join(q[', '], @languages) . q[')];
	say qq[      \@popularity = (] . join(', ', @ranks) . ')';
	say qq[Output:             ('] . join(q[', '], @order) . q[')];
}
