#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2026-05-04
use utf8;     # Week 372 - task 1 - Rearrange spaces
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

rearrange_spaces('aa bb cc bb ee      ');
rearrange_spaces('aa bb cc bb ee        ');
rearrange_spaces('  aa bb cc bb ee  ');
rearrange_spaces('abcde');
rearrange_spaces('abcde     ');
rearrange_spaces('     abcde');
rearrange_spaces('     ');
rearrange_spaces('');
rearrange_spaces('one two three four      ');

sub rearrange_spaces {
	
	my ($string, $rest, @words, $spaces, $fill, $extra, $word, $output);
	
	# initialise
	$string = $rest = $_[0];
	$spaces = 0;
	
	# collect words and count spaces
	while ($rest) {
		if ($rest =~ m|(^[^\s]+)(.*)|) {
			push @words, $1;
		} elsif ($rest =~ m|^(\s+)(.*)|) {
			$spaces += length $1;
		}
		$rest = $2;
	}
	
	# calculate inter-word spaces
	$fill = @words > 1 ? int($spaces / (@words - 1)) : 0;
	$extra = $spaces - $fill * (@words - 1);
	
	# build the output
	for $word (@words) {
		$output .= $word . (' ' x $fill);
	}
	$output = substr($output, 0, -$fill) if @words > 1;
	$output .= ' ' x $extra;
	
	# report
	say qq[\nInput:  '$string'];
	say qq[Output: '$output'];
}
