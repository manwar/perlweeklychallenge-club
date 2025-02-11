#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-02-10
use utf8;     # Week 308 - task 1 - Count common
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

count_common(['fred', 'jim', 'max', 'john'], ['john', 'bill', 'fred', 'alex']);
count_common(['fred', 'fred', 'fred'], ['joe', 'joe']);
count_common(['fred', 'fred', 'fred'], ['fred', 'fred', 'alice']);
count_common(['fred', 'fred', 'fred'], []);
count_common([], ['fred', 'fred', 'fred']);
count_common([], []);
count_common(['axe', 'bean', 'cabbage', 'dog', 'egg'], ['egg', 'axe', 'cabbage', 'bean', 'dog']);

sub count_common {
	
	my (@str1, @str2, $one, $count, $s);
	
	@str1 = @{$_[0]};
	@str2 = @{$_[1]};
	$count = 0;
	
	# join @str1 into a string separated by ~
	$one = '~' . join('~', @str1) . '~';
	
	# count times we can delete a member of @str2 from the string
	for $s (@str2) {
		$count ++ if $one =~ s|~$s~|~|;
	}
	
	say qq[\nInput:  \@str1 = ('] . join(q[', '], @str1) . qw[')];
	say qq[        \@str2 = ('] . join(q[', '], @str2) . qw[')];
	say qq[Output: $count];
}
