#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-07-08
use utf8;     # Week 277 - task 2 - Strong pair
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

my @ints;

strong_pair(1, 2, 3, 4, 5);
strong_pair(5, 7, 1, 7);
push @ints, int(rand(100)) for 0 .. 20;
strong_pair(@ints);

sub strong_pair {
	
	my (@ints, $i, $j, $x, $y, $output, $explain, %seen, $diff);
	
	# method 1 - initialise
	@ints = @_;
	$output = 0;
	$explain = '';
	
	# loop over all possible pairs
	for $i (0 .. @ints - 2) {
		for $j ($i + 1 .. @ints - 1) {
			($x, $y) = ($ints[$i], $ints[$j]);
			
			# check conditions and record
			next unless 0 < abs($x - $y) and abs($x - $y) < ($x < $y ? $x : $y);
			next if $seen{qq[$x/$y]};
			$seen{qq[$x/$y]} = 1;
			$seen{qq[$y/$x]} = 1;
			$output += 1;
			$explain .= qq[($x, $y), ];
		}
	}
	say '';
	multiline("Input: \@ints = ", join(', ', @ints), 58, ',', 3);
	multiline("Output1: $output - ", ($explain ? substr($explain, 0, -2) : '[none]'), 58, q[\),], 3);
#	printf(qq[\nInput:  \@ints = (%s)\n], join(', ', @ints));
#	printf(qq[Output1: %s - %s\n], $output, $explain ? substr($explain, 0, -2) : '[none]');
	
	# method 2 - initialise
	$output = 0;
	$explain = '';
	%seen = ();
	
	# sort and then loop over all pairs
	@ints = sort { $a <=> $b } @ints;
	I: for $i (0 .. @ints - 2) {
		J: for $j ($i + 1 .. @ints - 1) {
			($x, $y) = ($ints[$i], $ints[$j]);
			$diff = $y - $x;
			next J if $diff == 0 or $seen{qq[$x/$y]};
			
			# because @ints is sorted, increasing $j won't help
			next I if abs($diff) >= $x;
			$seen{qq[$x/$y]} = 1;
			$output += 1;
			$explain .= qq[($x, $y), ];
		}
	}
	multiline("Output2: $output - ", $explain ? substr($explain, 0, -2) : '[none]', 58, q[\),], 3);
#	printf(qq[Output2: %s - %s\n], $output, $explain ? substr($explain, 0, -2) : '[none]');	
}

sub multiline {
	
	my ($prefix, $text, $width, $separator, $margin, $this_line, $intro);
	
	($prefix, $text, $width, $separator, $margin) = @_;
	
	# split long string over lines max width $width
	$intro = $prefix;
	while (length($intro) + length($text) > $width) {
		$this_line = substr($text, 0, $width - length($intro));
		$this_line =~ m|(.*$separator)|;
		say $intro . $1;		
		$text =	substr($text, length($1), 99999);
		$intro = ' ' x $margin;
		$text =~ s|^\s*||;
	}
	say $intro . $text if $text !~ m|^\s*$|;
	return;
}