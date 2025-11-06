#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-11-03
use utf8;     # Week 346 - task 1 - Longest parenthesis
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

longest_parenthesis('(()())');
longest_parenthesis(')()())');
longest_parenthesis('((()))()(((()');
longest_parenthesis('))))((()(');
longest_parenthesis('()(()');
longest_parenthesis('))');
longest_parenthesis('()()()()()');
longest_parenthesis(')))())))');

sub longest_parenthesis {
	
	my (@parens, $best, $explain, $start, $i, $length, 
		$height, @opens, $this, %previous);
	
	# initialise
	@parens = split('', $_[0]);
	@opens = ();
	$best = $start = $height = 0;
	$explain = '';

	# loop over string
	for $i (0 .. $#parens) {
		$this = $parens[$i];
		
		# found ( - record as start
		if ($this eq '(') {
			push(@opens, $i);
			$height ++;
			
		# found )
		} elsif ($this eq ')' and $height > 0) {
			$height --;
			
			# ( and ) match
			unless ($height < 0) {
				$start = pop(@opens);
				
				# check for this being the longest
				$length = $i - $start + 1;
				if (defined $previous{end} and $start == $previous{end} + 1) {
					$length += $previous{length};
					$start = $previous{start};
				}
				
				# record info
				if ($length >= $best) {
					$explain = '' if $length > $best;
					$best = $length;
					$explain .= qq[($start .. $i), ];
					%previous = (start => $start, length => $length, end => $i);
				}
			
			# unmatched ) - forget all previous starts
			} else {
				@opens = ();
				$start = $i + 1;
			}
		}		
	}
	
	say qq[\nInput:  '$_[0]'];
	say qq[Output: ] . ($best > 0 ? qq[$best at ] . substr($explain, 0, -2) : 'none');
}
