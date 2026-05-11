#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2026-05-11
use utf8;     # Week 373 - task 1 - Equal list
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

equal_list(['a', 'bc'], ['a', 'bc']);
equal_list(['a', 'c', 'b'], ['abc']);
equal_list(['ab', 'c'], []);
equal_list(['', ''], ['', '', '']);
equal_list(['c', 'h', 'al', 'le', 'ng', 'e'], ['challenge']);
equal_list(['cha', 'llenge'], ['chall', 'enge']);

sub equal_list {
	
	my ($s, @joined);
	
	# concatenate the string elements
	@joined = ('', '');
	$joined[0] .= $_ for @{$_[0]};
	$joined[1] .= $_ for @{$_[1]};
	
	# report
	say qq[\nInput:  ('] . join(q[', '], @{$_[0]}) . q['), ('] . 
		join(q[', '], @{$_[1]}) . q[')];
	say qq[Output: ] . ($joined[0] eq $joined[1] ? 'true' : 'false');
}
