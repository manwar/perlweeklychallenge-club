#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-05-05
use utf8;     # Week 320 - task 1 - Maximum count
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

maximum_count(-3, -2, -1, 1, 2, 3);
maximum_count(-2, -1, 0, 0, 1);
maximum_count(1, 2, 3, 4);
maximum_count(0, 0, 0);

# larger example
my @nums;
push @nums, int(rand(41)) - 20 for 0 .. 99;
maximum_count(@nums);

sub maximum_count {
	
	my %count = (pos => 0, neg => 0, zero => 0);
	
	# count +ves, -ves and 0s
	$count{$_ < 0 ? 'neg' : ($_ > 0 ? 'pos' : 'zero')} ++ for @_;
	
	# report
	say qq[\nInput:  (] . join (', ', @_) . ')';;
	say qq[Output: ] . ($count{pos} > $count{neg} ? $count{pos} : $count{neg}) .
		qq[ ($count{neg} negative, $count{pos} positive, $count{zero} zero)];
}
