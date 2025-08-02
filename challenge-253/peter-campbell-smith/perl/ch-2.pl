#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-01-22
use utf8;     # Week 253 task 2 - Weakest row
use strict;   # Peter Campbell Smith
use warnings; 
binmode STDOUT, ':utf8';

weakest_row([[1, 1, 0, 0, 0],
             [1, 1, 1, 1, 0],
             [1, 0, 0, 0, 0],
             [1, 1, 0, 0, 0],
             [1, 1, 1, 1, 1]]);
			 
weakest_row([[1, 0, 0, 0],
             [1, 1, 1, 1],
             [1, 0, 0, 0],
             [1, 0, 0, 0]]);
			 		 
sub weakest_row {
	
	my ($matrix, $row, $ones, %scores, $row_number, $cell,%legend, @order);
	
	$matrix = shift;
	
	# count the ones in each row and construct %scores
	for $row (@$matrix) {
		$ones = 0;
		$ones += $_ for @$row;
		$scores{sprintf('%04d-%04d', $ones, $row_number ++)} = 1;
	}
	
	# list the number of 1s in each row and create @order
	for $row (sort keys %scores) {
		$row =~ m|(\d+)-(\d+)|;
		($ones, $row_number) = ($1, $2);
		$legend{$row_number} = sprintf("Row %d contains %d one%s", 
			$row_number, $ones, $ones == 1 ? '' : 's');
		push @order, $row_number + 0;
	}
	
	# show the results
	print_matrix(qq{Input:  [}, $matrix, 1);
	say qq[Output: (] . join(', ', @order) . ')';
	
	for $row (sort keys %legend) {
		say qq[        $legend{$row}];
	}	
}

sub print_matrix {
    
    my ($legend, $matrix, $j, $out, $max);

    ($legend, $matrix, $max) = @_;
    
    # format rows of matrix with numbers of equal width
    $out = '';
    for $j (0 .. @$matrix - 1) {
        $out .= qq[\n$legend] . join(', ', @{$matrix->[$j]}) . qq(]);
        $legend = (' ' x (length($legend) - 1)) . '[' if $j == 0;
    }
    $out =~ s|(\d+)|sprintf("%${max}d", $1)|ge;
    say qq[$out\n];
}
