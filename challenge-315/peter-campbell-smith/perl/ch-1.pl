#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-03-31
use utf8;     # Week 315 - task 1 - Find words
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

find_words([qw[the weekly challenge]], 'e');
find_words([qw[all cows eat grass]], 'a');
find_words([qw[some letters never occur]], 'z');
find_words([qw[all alligators are adept]], 'a');
find_words([qw[count best last attempt]], 't');
find_words([qw[if you cannot find it check the index]], 'x');

sub find_words {
	
	my (@list, $char, $found);
	@list = @{$_[0]};
	$char = $_[1];
	
	# find the elements of @list containg $char
	$found .= ($list[$_] =~ m|$char| ? qq[$_, ] : '') for 0 .. $#list;
	
	printf(qq[\nInput:  \@list = ('%s'), \$char = '%s'\n], join(qq[', '], @list), $char);
	say qq[Output: ] . ($found ? ('(' . substr($found, 0, -2) . ')') : 'none');
}
