#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2026-05-11
use utf8;     # Week 373 - task 2 - List division
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

list_division([1, 2, 3, 4, 5], 2);
list_division([1, 2, 3, 4, 5], 5);
list_division([1, 2, 3, 4, 5], 6);
list_division([1, 2, 3, 4, 5], 0);
list_division([11, 12, 13, 14, 15, 16, 17, 18, 19, 20], 4);

my @nums;
push(@nums, int(rand(100))) for 1 .. 50;
list_division(\@nums, int(rand(10)) + 1);

sub list_division {
	
	my (@list, $part, $parts, $extras, $output, $p);
	
	# initialise
	@list = @{$_[0]};
	$part = $_[1];
	if ($part <= @list and $part > 0) {
		
		# determine no of parts and extras
		$parts = int(@list / $part);
		$extras = @list % $part;
		$output = '((';
		
		# loop over parts
		for $p (1 .. $parts) {
			
			# add extras to first part
			while ($extras) {
				$output .= shift(@list) . ', ';
				$extras --;
			}
			
			# and add $part entries to this part
			$output .= shift(@list) . ', ' for (1 .. $part);
			$output =~ s|, $|), (|;
		}
		$output =~ s|, \($|)|;
	
	# $int is invalid
	} else {
		$output = -1;
	}
	
	# report
	say qq[\nInput:  \@list = (] . join(', ', @{$_[0]}) . 
		qq[), \$int = $part];
	say qq[Output: $output];
}
