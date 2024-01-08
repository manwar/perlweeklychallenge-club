#!/usr/bin/perl

use v5.16;    # The Weekly Challenge - 2024-01-08
use utf8;     # Week 251 task 2 - Lucky numbers
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

binmode STDOUT, ':utf8';

lucky_numbers([[ 3,  7,  8],
               [ 9, 11, 13],
               [15, 16, 17]]);
			   
lucky_numbers([[ 1, 10,  4,  2],
               [ 9,  3,  8,  7],
               [15, 16, 17, 12]]);
			   
lucky_numbers([[7, 8],
               [1, 2]]);
			   
lucky_numbers([[1, 2, 3],
			   [2, 1, 4],
			   [3, 4, 1]]);
			   
lucky_numbers([[7, 4, 4, 7],
			   [6, 5, 5, 6],
			   [6, 5, 5, 6],
			   [7, 4, 4, 7]]);
			    
			   			
sub lucky_numbers {
	
	my ($r, $c, @lucky);
	our ($m, @mins, @maxs);
	@mins = @maxs = ();
	
	$m = shift;
	
	# loop over elements of matrix
	for $r (0 .. @$m - 1) {
		for $c (0 .. @{$m->[0]} - 1) {
			
			# save value if element is lucky
			push(@lucky, $m->[$r]->[$c]) if (min_in_row($r, $c) and max_in_col($r, $c));
		}
	}
	say format_matrix(qq{\nInput: \@matrix = }, $m);
	say qq[Output: ] . (@lucky > 0 ? join(', ', @lucky) : -1);

	sub min_in_row {
		
		my ($r, $c, $cx, $min_value);
		
		# return true/false if element $m($r, $c) is the minimum in its row
		($r, $c) = @_;
		
		# return saved value if we've been here before
		return ($mins[$r] == $m->[$r]->[$c] ? 1 : 0) if defined $mins[$r];
		
		# or determine and save it if not
		$min_value = 99999;
		for $cx (0 .. @{$m->[0]} - 1) {
			$min_value = $m->[$r]->[$cx] if $m->[$r]->[$cx] < $min_value;
		}
		$mins[$r] = $min_value;
		return $m->[$r]->[$c] == $min_value;
	}
	
	sub max_in_col {
		
		my ($r, $c, $rx, $max_value);
		
		# return true/false if element $m($r, $c) is the maximum in its column
		($r, $c) = @_;

		# return saved value if we've been here before
		return ($maxs[$c] == $m->[$r]->[$c] ? 1 : 0) if defined $maxs[$c];
		
		# or determine and save it if not
		$max_value = -99999;
		for $rx (0 .. @$m - 1) {
			$max_value = $m->[$rx]->[$c] if $m->[$rx]->[$c] > $max_value;
		}
		$maxs[$c] = $max_value;
		return $m->[$r]->[$c] == $max_value;
	}
}

sub format_matrix {
	
	# format the output
	my ($w, $m, $r, $c, $prefix, $width, $rubric, $spaces, $line);
	
	($rubric, $m) = @_;
	$spaces = length($rubric);
	
	# find maximum width of element as printed by Perl
	$w = 0;
	for $r (0 .. @$m - 1) {
		for $c (0. .. @{$m->[0]} - 1) {
			$width = length($m->[$r]->[$c]);
			$w = $width if $width > $w;
		}
	}
	
	# construct and output each row of matrix
	for $r (0 .. @$m - 1) {
		$line = $rubric . '[';
		for $c (0 .. @{$m->[0]} - 1) {
			$line .= sprintf("%${w}d", $m->[$r]->[$c]) . ', ';
		}
		$line =~ s|, $|]|;
		print $line;
		say '' unless $r == @$m - 1;
		$rubric = (' ' x ($spaces - 1));
	}
}
