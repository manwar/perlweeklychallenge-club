#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2026-06-01
use utf8;     # Week 376 - task 2 - Doubled words
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

doubled_words(qq[One day day when Pooh Bear had nothing else to do, 
do he thought he would do something, so he went round to Piglet's 
house to see what Piglet was doing. It was still snowing as he 
stumped over the white forest track, and he expected to find Piglet 
warming his toes in front of his fire, fire but to his surprise he 
saw that the door was open, and the more he looked inside the more 
Piglet wasn't wasn't there!

"He's out," out said Pooh sadly. "That's what it is. He's not in. 
I shall have to go a fast <b>Thinking Walk</b> walk by myself. 
Bother! Bother!"]);

# from Winnie-The-Pooh by A A Milne
# https://en.wikipedia.org/wiki/Winnie-the-Pooh

sub doubled_words {

	my ($html, $in_word, $is_word, $input, $j, $last_word, $line, 
		$text, $this_bit, $w, @chars, @starts, @words);
		
	# initialise
	$input = $_[0];
	@chars = split(//, $input);
	$in_word = 1;
	$w = -1;	

	# ensure we start with a non-word
	unshift(@chars, '~') if $chars[0] =~ m|[-a-z']|i;
	
	# loop over chars in $text
	$html = 0;
	for $j (0 .. $#chars) {
		
		# a word character (but not an HTML tag)
		if ($chars[$j] =~ m|[-a-z']|i and not $html) {
			if ($in_word == 0) {
				$in_word = 1;
				$w ++;
			}
			$words[$w] .= $chars[$j];	
			
		# a non-word character
		} else {
			$html = 1 if $chars[$j] eq '<';
			$html = 0 if $chars[$j] eq '>';
			if ($in_word == 1) {
				$in_word = 0;
				$w ++;
			}			
			$words[$w] .= $chars[$j];	
		}
	}
	
	# recreate the text
	for ($w = 3; $w <= $#words; $w += 2) {
		
		# bracket duplicated words
		if (lc($words[$w]) eq lc($words[$w - 2])) {
			$words[$w - 2] = qq{[$words[$w - 2]]};
			$words[$w] = qq{[$words[$w]]};
		}
	}
	$words[0] = '' if $words[0] eq '~';
	$text = join('', @words) . qq[\n];

	
	# report
	say qq[\nInput:<pre>\n$input</pre>];
	say qq[\nOutput:<pre>];
	while ($text =~ m|(.*?)\n|g) {
		$line = $1;
		say $line if $line =~ m|\[|;
	}
	say q[</pre>];
}	
