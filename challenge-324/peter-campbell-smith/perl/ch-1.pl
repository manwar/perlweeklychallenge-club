#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-06-02
use utf8;     # Week 324 - task 1 - 2d array
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

two_d_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], 3, 4);
two_d_array([1, 2, 3], 1, 3);
two_d_array([1, 2, 3, 4], 4, 1);

# bigger example
my $matrix;
push @$matrix, int(rand(1000)) for 0 .. 76;
two_d_array($matrix, 11, 7);

sub two_d_array {
	
	my ($integers, $rr, $cc, $j, $r, $c, $array, $w);
	
	# initialise
	($integers, $rr, $cc) = @_;
	if (@$integers != $rr * $cc) {
		say qq[\@integers must have $rr * $cc elements];
		exit;
	}
	
	# get width of largest number for formatting matrix
	$w = 0;
	$w = length($_) > $w ? length($_) : $w for @$integers;
	
	# fill in matrix
	for $j (0 .. @$integers - 1) {
		$r = int($j / $cc);
		$c = $j % $cc;
		$array->[$r]->[$c] = sprintf("%${w}d", $integers->[$j]);
	}
	
	# report
	say qq[\nInput:  \@integers = (] . join(', ', @$integers) . qq[), \$rows = $rr, \$cols = $cc];
	print_matrix('Output: @matrix =  ', $array);
}

sub print_matrix {
	
	my ($legend, $matrix, $j);

	# format matrix
	($legend, $matrix) = @_;
	for $j (0 .. @$matrix - 1) {
		say qq{$legend [} . join(', ', @{$matrix->[$j]}) . qq(]);
		$legend = ' ' x length($legend);
	}
}

