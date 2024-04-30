#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-04-292
use utf8;     # Week 267 - task 2 - Line counts
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

line_counts('abcdefghijklmnopqrstuvwxyz', 
	[10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 
	 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10]);
line_counts('bbbcccdddaaa', 
	[ 4, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 
	 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10]);
line_counts('thequickbrownfoxjumpsoverthelazydog', 
	[15, 27, 12, 28, 16, 29, 33, 21, 14, 29, 36, 13, 14, 
	 9, 18, 23, 22, 35, 27, 15, 25, 21, 19, 35, 23, 15]);

sub line_counts {
	
	my ($str, @widths, $ch, $limit, %pixels, $lines, 
		$chars, $j, $line, @lines, @line_length);
	
	$str = $_[0];
	@widths = @{$_[1]};
	$limit = 100;
	
	# set $pixels{$char} to the width of $char
	for $j (0 .. 25) {
		$pixels{chr(ord('a') + $j)} = $widths[$j];
	}
	
	# loop over characters in $str
	$line = 0;
	$chars = $limit;
	while ($str =~ m|([a-z])|g) {
		
		# needs a new line
		$ch = $1;
		if ($chars + $pixels{$ch} > $limit) {
			$line ++;
			$chars = $pixels{$ch};
			
		# fits on current line
		} else {
			$chars += $pixels{$ch};
		}
		
		# save for explanation
		$lines[$line] .= $ch;
		$line_length[$line] += $pixels{$ch};
	}
	
	# results
	say qq[\nInput:  \@str = '$str'];
	say qq[        \$widths = (] . join(', ', @widths[0 .. 12]) . ',';
	say qq[                   ] . join(', ', @widths[13 .. 25]) . ')';
	say qq[Output: ($line, $chars)];
	for $j (1 .. @lines - 1) {
		say qq[        Line $j: $lines[$j] ($line_length[$j] pixels)];
	}
	
}
