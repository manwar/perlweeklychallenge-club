#!/usr/bin/env perl
# Perl Weekly Challenge 88 task 2 Spiral Matrix
# Print elements of matrix along spiral
use warnings;
use strict;
use feature qw(say);

say join " ", "Example 1:", spiral_matrix([1,2,3],[4,5,6],[7,8,9]);
say join " ", "Example 2:", spiral_matrix([1,2,3,4],[5,6,7,8],[9,10,11,12],[13,14,15,16]);
# output:
# Example 1: 1 2 3 6 9 8 7 4 5
# Example 2: 1 2 3 4 8 12 16 15 14 13 9 5 6 7 11 10
sub spiral_matrix {
    use PDL; #use the perl data language
    use PDL::NiceSlice;
    my $input =pdl(@_); #input piddle (PDL 2D array)
    my @output;
    return if $input->dim(1)==0; # 0 rows no elements
    while($input->dim(0) > 0){ #until no more columns
	push @output, $input->(:,(0))->list; # walk through row
	last if $input->dim(1)==1; # no more rows
	$input=$input->(-1:0,1:-1) #reflect rows, remove one row
	    ->transpose; # rotate
    }
    return @output
}
