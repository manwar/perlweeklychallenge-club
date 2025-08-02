#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-03-31
use utf8;     # Week 315 - task 2 - Find third
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

find_third(qq[Perl is my favourite language but Python is my favourite too.], 'my', 'favourite');
find_third(qq[I like honey, I like sugar, I like everything sweet!], 'I', 'like');
find_third(qq[I like honey, I like sugar, I like everything sweet!], 'everything', 'sweet');
find_third(qq[You  can   include ODD   SPACING], 'include', 'odd');

sub find_third {
	
	my ($sentence, $first, $second, $output);
	
	($sentence, $first, $second) = @_;
	say qq[\nInput:  \$sentence = '$sentence',\n        \$first = '$first', \$second = '$second'];

	# match the two words and pick up the third
	$sentence =~ s|[^a-zA-Z]| |g;
	$output .= qq['$1', ] while $sentence =~ m|$first\s+$second\s+([a-z]+)|gi;
	
	say 'Output: ', ($output ? '(' . substr($output, 0, -2) . ')' : 'none');
}
