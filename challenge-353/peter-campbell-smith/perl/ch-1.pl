#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-12-22
use utf8;     # Week 353 - task 1 - Max words
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

max_words('Hello world', 'This is a test', 'Perl is great');
max_words('The quick brown fox jumps over the lazy dog', 
	'A', 'She sells seashells by the seashore', 'To be or 
	not to be that is the question');
max_words('one', 'two', 'three');
max_words("George's boots are clean");
max_words("she said 'ice-cream is lovely'");
max_words();

sub max_words {
	
	my (@sentences, $max_words, $sentence, @words);
	
	# initialise
	@sentences = @_;
	$max_words = 0;
	
	# loop over sentences
	for $sentence (@sentences) {
		
		# split into words and count them
		@words = split('\s+', $sentence);
		$max_words = @words if @words > $max_words;
	}
	
	
	say qq{\nInput:  [} . join('], [', @sentences) . ']';
	say qq[Output: $max_words];
}
