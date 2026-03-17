#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2026-03-16
use utf8;     # Week 365 - task 2 - Valid token counter
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

valid_token_counter('cat and dog');
valid_token_counter('a-b c! d,e');
valid_token_counter('hello-world! this is fun');
valid_token_counter('ab- cd-ef gh- ij!');
valid_token_counter('wow! a-b-c nice.');

sub valid_token_counter {
	
	my ($string, $valid, $word, @words, $count, @z, $good);
	
	# initialise
	$string = $_[0];
	$valid = 0;
	$good = '';
	
	# loop over words
	@words = split(/\s+/, $string);
	for $word (@words) {
		next if $word =~ m|\d|;   # no digits
		$count = @z = $word =~ m|\-|g; # count hyphens
		next if $count > 1;
		next if ($count == 1 and not $word =~ m|[a-z]\-[a-z]|);
		$count = @z = $word =~ m|[!\.,]|; # count punctuation
		next if $count > 1;
		next if ($count == 1 and not $word =~ m|[!\.,]$|);
		
		# passes all tests
		$valid ++;
		$good .= qq['$word', ];
	}
	$good = ' - (' . substr($good, 0, -2) . ')' if $good;
	
	say qq[\nInput:  '$string'];
	say qq[Output: $valid valid tokens $good];
}
