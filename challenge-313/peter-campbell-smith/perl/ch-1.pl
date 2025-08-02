#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-03-17
use utf8;     # Week 313 - task 1 - Broken keys
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

broken_keys('perl', 'perrrl');
broken_keys('raku', 'rrakuuuu');
broken_keys('python', 'perl');
broken_keys('coffeescript', 'cofffeescccript');
broken_keys('perrl', 'perl');
broken_keys('perrl', 'perrl');
broken_keys('perl', 'perlperl');

sub broken_keys {
	
	my ($correct, $wrong, $pattern);
	
	($correct, $wrong) = @_;
	
	# build a regular expression
	$pattern .= qq/[$_]+/ for split('', $correct);
	
	# use it to produce output
	say qq[\nInput:  \$correct = '$correct', \$wrong = '$wrong'];
	say qq[Output: ] . ($wrong =~ m|^$pattern$| ? 'true' : 'false');
}
