#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-04-07
use utf8;     # Week 316 - task 1 - Circular
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

circular('perl', 'loves', 'scala');
circular('love', 'eggs', 'scrambled');
circular('love', 'scrambled', 'eggs');
circular(qw[koala antelope elephant tiger rhino ostrich hen narwhal leopard donkey yak]);
circular(qw[the elegant tawny yak kicks slippery fish]);

sub circular {
	
	my (@list, $j);
	
	#initialise
	@list = @_;
	say qq[\nInput:  \@list = ('] . join(q[', '], @list) . q[')];
	
	# check for compliance
	for $j (0.. $#list - 1) {
		if (substr($list[$j], -1, 1) ne substr($list[$j + 1], 0, 1)) {
			say qq[Output: no - '$list[$j]' and '$list[$j + 1]'];
			return;
		}
	}
	
	# no problems
	say qq[Output: yes];
}
