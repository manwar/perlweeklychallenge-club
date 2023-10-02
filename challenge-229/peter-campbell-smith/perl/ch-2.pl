#!/usr/bin/perl

use v5.16;    # The Weekly Challenge - 2023-08-07
use utf8;     # Week 229 task 2 - Two out of three
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

two_out_of_three([1, 1, 2, 4], [2, 4], [4]);
two_out_of_three([1, 3, 2], [3, 1, 2], [2, 1, 3]);
two_out_of_three([1, 2, 3], [4, 5, 6], [7, 8, 9]);

# random example
my ($j, @array1, @array2, @array3);
for $j (0 .. 9) {
	push @array1, int(rand(90));
	push @array2, int(rand(90));
	push @array3, int(rand(90));
}
two_out_of_three(\@array1, \@array2, \@array3);
		

sub two_out_of_three {
	
	my ($j, %present, $n, $good);
	
	# for each value v in array n appends an n to present{v}
	for $j (1 .. 3) {
		$present{$_} .= $j for @{$_[$j - 1]};
	}
	
	# if v is in at least two arrays, present{v} will contain 12, 23 or 13
	for $n (keys %present) {
		$good .= qq[$n, ] if $present{$n} =~ m!12|13|23!;
	}
	
	say qq[\nInput: \@array1 = (], join(', ', @{$_[0]}) . qq[)] .
		qq[\n       \@array2 = (], join(', ', @{$_[1]}) . qq[)] .
		qq[\n       \@array3 = (], join(', ', @{$_[2]}) . qq[)];
	say qq[Output: (] . ($good ? substr($good, 0, -2) : 'none') . qq[)];
	
}